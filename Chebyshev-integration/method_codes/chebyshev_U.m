function U = chebyshev_U(X, n)
    % Ta funkcja tworzy macierz wielomianów Czebyszewa drugiego rodzaju
    % Kolumny macierzy to kolejne stopnie wielomianu
    % Wiersze macierzy odpowiadają za kolejne wartosci wielomianu dla x z
    % wektora X
    % X - wektor wartości, dla których obliczane są wielomiany
    % n - liczba wielomianów do utworzenia (stopień od 0 do n-1)
    % Zwracana macierz U ma wymiar length(X) x n

    % Upewniamy się, że X jest kolumnowym wektorem
    X = X(:);

    % Liczba punktów (wierszy) w wektorze X
    m = length(X);

    % Inicjalizacja macierzy U
    U = zeros(m, n);

    % Wielomiany U_0(x) i U_1(x) wypełniają pierwsze dwie kolumny
    U(:, 1) = 1; % U_0(x) = 1
    if n > 1
        U(:, 2) = 2 * X; % U_1(x) = 2x
    end

    % Rekurencyjne wyliczanie pozostałych wielomianów
    for k = 3:n
        U(:, k) = 2 * X .* U(:, k-1) - U(:, k-2); % U_k(x) = 2xU_{k-1}(x) - U_{k-2}(x)
    end
end