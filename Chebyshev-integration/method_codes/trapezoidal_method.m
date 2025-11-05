function result = trapezoidal_method(A, a, b, N)
    % A - wektor współczynników wielomianu
    % a, b - początek i koniec przedziału całkowania
    % N - liczba podziałów przedziału
    % Funkcja zwraca przybliżoną wartość całki obliczoną metodą trapezów.

    % Tworzymy wektor punktów podziału na przedziale [a, b]
    X = linspace(a, b, N+1);

    % Wyznaczamy krok podziału
    h = (b - a) / N;

    % Obliczamy wartości funkcji w punktach X za pomocą evaluate_polynomial
    Y = evaluate_polynomial(X', A);

    % Stosujemy metodę trapezów
    % Całka ≈ h/2 * (f(a) + 2*f(x_1) + 2*f(x_2) + ... + 2*f(x_{N-1}) + f(b))
    result = h * (0.5 * Y(1) + sum(Y(2:end-1)) + 0.5 * Y(end));
end
