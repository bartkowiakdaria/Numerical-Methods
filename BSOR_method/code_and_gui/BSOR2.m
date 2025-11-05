function [x, iter, rho_B, rel_error] = BSOR2(A, b, omega, tol, max_iter, x)
    % BSOR: Metoda wstecznej sukcesywnej nadrelaksacji do rozwiązywania Ax = b
    % Parametry ejścia:
    %   A        - Macierz współczynników (n x n)
    %   b        - Wektor prawej strony (n x 1)
    %   omega    - Parametr relaksacji
    %   tol      - Tolerancja zbieżności
    %   max_iter - Maksymalna liczba iteracji
    %   x        - Przybliżenie początkowe
    % Parametry wyjścia:
    %   x        - Wektor rozwiązania (n x 1)
    %   iter     - Liczba wykonanych iteracji
    %   rho_B    - Promień spektralny macierzy iteracji
    %   rel_error - Błąd względny ostatniej iteracji

    n = size(A, 1);  % Liczba zmiennych
    iter = 0;        % Inicjalizacja licznika iteracji
    rel_error = inf; % Błąd względny
    x_old = x;       % Kopia wektora początkowego

    % Konstrukcja macierzy iteracji B - aby obliczyć promień spektralny
    L = tril(A, -1);     % Macierz dolna (poniżej diagonali)
    D = diag(diag(A));   % Macierz diagonalna
    U = triu(A, 1);      % Macierz górna (powyżej diagonali)

    B = (D + omega * L) \ ((1 - omega) * D - omega * U);  
    rho_B = max(abs(eig(B)));  % Promień spektralny macierzy iteracji

    while iter < max_iter
        x_old = x;  % Zachowanie poprzedniego wektora rozwiązania

        % Wsteczna pętla iteracyjna (od n do 1)
        for i = n:-1:1
            sigma1 = sum(A(i, i+1:n) .* x(i+1:n)');  % Suma dla j > i
            sigma2 = sum(A(i, 1:i-1) .* x(1:i-1)');  % Suma dla j < i
            x(i) = (1 - omega) * x_old(i) + omega * (b(i) - sigma1 - sigma2) / A(i, i);
        end

        % Obliczenie błędu względnego
        rel_error = norm(x - x_old, inf) / norm(x, inf);

        % Sprawdzenie warunku zbieżności
        if rel_error < tol
            break;
        end

        iter = iter + 1;  % Zwiększenie licznika iteracji
    end
end

