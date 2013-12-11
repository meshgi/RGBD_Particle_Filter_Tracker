function pr = bb_normalize_likelihood (li)

normal_li = li / max(li);
pr = li / sum (li);

