% TEST SKRYPT: Porównanie metody trapezów z funkcją MATLAB 'integral'

% Wyczyszczenie środowiska
clc; clear; close all;

% Przedział całkowania
a = -1; b = 1;

% Lista przykładów współczynników wielomianów
przyklady = {
    [1; -1; 1],                                                          % Wielomian T_0(x), T_1(x), T_2(x) - prosty przypadek                                                 
    [1; 2; 3; 4; 1; 3; 4; 6; 8; 1; 6; 4],                                % Wielomian wysokiego rzędu 
    [5; 10; 200; 100; 10000],                                            % Wielomian o dużych współczynnikach
    [-1; -10; -100; -5; -1],                                             % Wielomian z ujemnymi współczynnikami
    [10^6; 10^5],                                                        % Wielomian o bardzo dużych współczynnikach
    [10^6; 10^5; 100; 100; 10^7; 10^5; 10^4; 10^3; 10; 100; 10^8; 100]   % Wielomian wysokiego rzędu i o bardzo dużych współczynnikach
};

% Liczba podziałów dla metody trapezów
N_values = [1, 10, 50, 100, 1000];

% Wyniki dla każdego przykładu
for i = 1:length(przyklady)
    if i == 1
    disp('--- 1. Prosty przypadek wielomianu ---');
    end
    if i == 2
    disp('--- 2. Wielomian wysokiego rzędu ---');
    end
    if i == 3
    disp('--- 3. Wielomian o dużych współczynnikach ---');
    end
    if i == 4
    disp('--- 4. Wielomian z ujemnymi współczynnikami ---');
    end
    if i == 5
    disp('--- 5. Wielomian o bardzo dużych współczynnikach ---');
    end
    if i == 6
    disp('--- 6. Wielomian wysokiego stopnia i o bardzo dużych współczynnikach ---');
    end
    
    A = przyklady{i};
    fprintf('Współczynniki wielomianu: ');
    disp(A');

    % Tworzenie funkcji wielomianowej
    polynomial_func = @(x) evaluate_polynomial(x, A);

    % Dokładna wartość całki za pomocą funkcji 'integral'
    calka_matlab = integral(polynomial_func, a, b, "ArrayValued",true);
    fprintf('Dokładna całka (MATLAB): %.6f\n', calka_matlab);

    % Wyniki dla różnych N
    for N = N_values
        % Obliczenie całki metodą trapezów
        calka_trapezy = trapezoidal_method(A, a, b, N);

        % Obliczenie błędu względnego
        blad_wzgledny = abs(calka_trapezy - calka_matlab) / abs(calka_matlab);

        % Obliczenie błędu bezwzględnego
        blad_bezwzgl = abs(calka_trapezy - calka_matlab);

        % Wyświetlenie wyników
        fprintf('N = %d: Metoda trapezów = %.6f, Błąd względny = %.6f, Błąd bezwzględny = %.6f\n', ...
                N, calka_trapezy, blad_wzgledny, blad_bezwzgl);
    end
    fprintf('\n');
end
