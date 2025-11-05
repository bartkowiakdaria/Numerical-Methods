function T = chebyshev_T(X, n)
    % Ta funkcja tworzy macierz wielomianów Czebyszewa pierwszego rodzaju
    % Kolumny macierzy to kolejne stopnie wielomianu
    % Wiersze macierzy odpowiadają za kolejne wartosci wielomianu dla x z
    % wektora X
    % X - wektor wartości, dla których obliczane są wielomiany
    % n - liczba wielomianów do utworzenia (stopień od 0 do n-1)
    % Zwracana macierz T ma wymiar length(X) x n

    % Przekształcenie X w wektor kolumnowy
    X = X(:);
    
    % Liczba punktów (wierszy) w wektorze X
    m = length(X);
    
    % Inicjalizacja macierzy T
    T = zeros(m, n);
    
    % Wielomiany T_0(x) i T_1(x) wypełniają pierwsze dwie kolumny
    T(:, 1) = 1; % T_0(x) = 1
    if n > 1
        T(:, 2) = X; % T_1(x) = x
    end
    
    % Rekurencyjne wyliczanie pozostałych wielomianów
    for k = 3:n
        T(:, k) = 2 * X .* T(:, k-1) - T(:, k-2); % T_k(x) = 2xT_{k-1}(x) - T_{k-2}(x)
    end
end