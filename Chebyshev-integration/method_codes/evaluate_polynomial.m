function W = evaluate_polynomial(X, A)
    % Ta funkcja oblicza wartości wielomianu w punktach X na podstawie
    % współczynników A oraz macierzy Czebyszewa pierwszego i drugiego rodzaju.
    % Stworzymy macierz, w której każda komórka to iloczyn komórek z
    % macierzy wielomianu Czebyszewa 1 rodzaju i 2 rodzaju. Następnie
    % przemnożymy ją przez pionowy wektor ze współczynnikami a_k
    % X - wektor punktów, w których obliczamy wartości wielomianu
    % A - wektor pionowy współczynników (n x 1)
    % W - wektor wyników (wartości wielomianu w punktach X)

    % Upewniamy się, że X i A są kolumnowymi wektorami
    X = X(:);
    A = A(:);

    % Liczba współczynników określa wymiar wielomianu
    n = length(A);

    % Obliczenie macierzy wielomianów Czebyszewa pierwszego rodzaju (T)
    T = chebyshev_T(X, n);

    % Obliczenie macierzy wielomianów Czebyszewa drugiego rodzaju (U)
    U = chebyshev_U(X, n);

    % Punktowy iloczyn macierzy T i U
    M = T .* U;

    % Obliczenie wartości wielomianu jako M * A
    W = M * A;
end


