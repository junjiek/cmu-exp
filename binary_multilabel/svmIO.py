from contextlib import closing
import io
import os.path

import numpy as np
import scipy.sparse as sp

from sklearn.externals import six
from sklearn.externals.six import u, b
from sklearn.externals.six.moves import range, zip
from sklearn.utils.validation import check_array


def _dump_svmlight(X, y, f, one_based, comment, query_id):
    is_sp = int(hasattr(X, "tocsr"))
    if X.dtype.kind == 'i':
        value_pattern = u("%d:%d")
    else:
        value_pattern = u("%d:%.16g")

    line_pattern = u("%s")

    line_pattern += u(" %s\n")

    for i in range(X.shape[0]):
        if is_sp:
            span = slice(X.indptr[i], X.indptr[i + 1])
            row = zip(X.indices[span], X.data[span])
        else:
            nz = X[i] != 0
            row = zip(np.where(nz)[0], X[i, nz])

        s = " ".join(value_pattern % (j + one_based, x) for j, x in row)
        label = ""
        first = True
        for l in y[i]:
            if not first:
                label += ","
            label += str(int(l))
            first = False
        feat = (label, s)
        f.write((line_pattern % feat).encode('ascii'))


def dump_svmlight_file(X, y, f, zero_based=True, comment=None, query_id=None):

    y = np.asarray(y)
    if y.ndim != 1:
        raise ValueError("expected y of shape (n_samples,), got %r"
                         % (y.shape,))

    Xval = check_array(X, accept_sparse='csr')
    if Xval.shape[0] != y.shape[0]:
        raise ValueError("X.shape[0] and y.shape[0] should be the same, got"
                         " %r and %r instead." % (Xval.shape[0], y.shape[0]))

    # We had some issues with CSR matrices with unsorted indices (e.g. #1501),
    # so sort them here, but first make sure we don't modify the user's X.
    # TODO We can do this cheaper; sorted_indices copies the whole matrix.
    if Xval is X and hasattr(Xval, "sorted_indices"):
        X = Xval.sorted_indices()
    else:
        X = Xval
        if hasattr(X, "sort_indices"):
            X.sort_indices()

    if query_id is not None:
        query_id = np.asarray(query_id)
        if query_id.shape[0] != y.shape[0]:
            raise ValueError("expected query_id of shape (n_samples,), got %r"
                             % (query_id.shape,))

    one_based = not zero_based

    if hasattr(f, "write"):
        _dump_svmlight(X, y, f, one_based, comment, query_id)
    else:
        with open(f, "wb") as f:
            _dump_svmlight(X, y, f, one_based, comment, query_id)