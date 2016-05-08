ae1 = train_nn(9, 9, 6, x, y);

[x1, y1] = get_next_input_output(ae1, x, y);

ae2 = train_nn(6, 6, 3, x1, y1);

[x2, y2] = get_next_input_output(ae2, x1, y1);

ae3 = train_nn(3, 3, 1, x2, y2);



