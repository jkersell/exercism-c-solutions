#include "high_scores.h"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>


int32_t latest(const int32_t *scores, size_t scores_len) {
    return scores[scores_len - 1];
}


int32_t personal_best(const int32_t *scores, size_t scores_len) {
    int32_t best = 0;
    for (size_t i = 0; i < scores_len; i++) {
        best = scores[i] > best ? scores[i] : best;
    }
    return best;
}


static size_t find_place(const int32_t *arr, size_t arr_len, int32_t value) {
    /* This function returns the index that value should be inserted at in arr in
     * order to maintain the sorted order of arr from highest to lowest.
     */
    for (size_t i = 0; i < arr_len; i++) {
        if (value > arr[i]) {
            return i;
        }
    }
    return arr_len;
}


static void insert_at(int32_t *arr, size_t arr_len, size_t position, int32_t value) {
    /* This function inserts value into arr at the index given by position. Any elements
     * after the positionth index will be shifted to the right. If position is out of
     * bounds, as determined by arr_len, an error code is returned.
     */
    assert(position < arr_len);
    for (size_t i = arr_len - 1; i > position; i--) {
        arr[i] = arr[i - 1];
    }
    arr[position] = value;
}


size_t personal_top_three(const int32_t *scores, size_t scores_len, int32_t *output) {
    size_t output_size = 0;
    for (size_t i = 0; i < scores_len; i++) {
        size_t insert_to = find_place(output, output_size, scores[i]);
        if (insert_to < 3) {
            insert_at(output, 3, insert_to, scores[i]);
            if (output_size < 3) {
                output_size++;
            }
        }
    }

    return output_size;
}
