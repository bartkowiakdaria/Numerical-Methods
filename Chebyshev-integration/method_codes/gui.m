function gui
    % Główna funkcja tworząca GUI

    % Tworzymy główne okno
    fig = uifigure('Name', 'Metoda Trapezów', 'Position', [100, 100, 800, 600]);

    % Label i pole tekstowe dla przedziału a
    uilabel(fig, 'Position', [20, 550, 150, 22], 'Text', 'Początek przedziału (a):');
    aEdit = uieditfield(fig, 'numeric', 'Position', [200, 550, 100, 22]);

    % Label i pole tekstowe dla przedziału b
    uilabel(fig, 'Position', [20, 500, 150, 22], 'Text', 'Koniec przedziału (b):');
    bEdit = uieditfield(fig, 'numeric', 'Position', [200, 500, 100, 22]);

    % Label i pole tekstowe dla liczby podziałów N
    uilabel(fig, 'Position', [20, 450, 150, 22], 'Text', 'Liczba podziałów (N):');
    nEdit = uieditfield(fig, 'numeric', 'Position', [200, 450, 100, 22]);

    % Label i pole tekstowe dla współczynników A_k
    uilabel(fig, 'Position', [20, 400, 150, 22], 'Text', 'Współczynniki (A_k):');
    aCoeffsEdit = uieditfield(fig, 'text', 'Position', [200, 400, 200, 22], ...
        'Placeholder', 'Np. 1, -2, 3');

    % Przycisk do obliczenia
    calculateButton = uibutton(fig, 'Position', [200, 350, 100, 30], ...
        'Text', 'Oblicz', 'ButtonPushedFcn', @(btn, event) calculate_integral());

    % Pole tekstowe wyników
    resultLabel = uilabel(fig, 'Position', [20, 220, 360, 80], 'Text', '');

    % Tworzenie osi wykresu
    ax = uiaxes(fig, 'Position', [450, 200, 300, 300]);
    title(ax, 'Błąd bezwzględny');
    xlabel(ax, 'N');
    ylabel(ax, 'Błąd');
    
    
    function calculate_integral()
        % Funkcja wywoływana po naciśnięciu przycisku "Oblicz"

        % Pobranie danych od użytkownika
        a = aEdit.Value;
        b = bEdit.Value;
        N = nEdit.Value;
        A = str2num(aCoeffsEdit.Value); %#ok<ST2NM>
    
        if isempty(A) || N <= 0 || b <= a
            resultLabel.Text = 'Nieprawidłowe dane wejściowe.';
            return;
        end
    
        try
            % Obliczenie dokładnej wartości całki
            polynomial_func = @(x) evaluate_polynomial(x, A);
            symbolicValue = integral(polynomial_func, a, b, 'ArrayValued', true);
    
            % Obliczenie wartości całki metodą trapezów dla wybranego N
            trapezoidalValue = trapezoidal_method(A, a, b, N);
    
            % Obliczenie błędu bezwzględnego
            absError = abs(symbolicValue - trapezoidalValue);
    
             
            % Obliczenie błędu względnego
            relError = abs(absError / symbolicValue);

            % Wyświetlenie wyników
            resultLabel.Text = sprintf(...
                'Metoda trapezów: %.6f\nDokładna całka: %.6f\nBłąd względny: %.6f\nBłąd bezwzględny: %.6f', ...
                trapezoidalValue, symbolicValue, relError, absError);
            
            
            % Obliczenie błędów bezwzględnych dla N od 1 do 1000
            maxN = 1000;
            errors = zeros(maxN, 1);
            for i = 1:maxN
                errors(i) = abs(symbolicValue - trapezoidal_method(A, a, b, i));
            end
    
            % Rysowanie wykresu błędu
            plot(ax, 1:maxN, errors, 'b', 'LineWidth', 1.5);
            hold(ax, 'on');
            
            % Zaznaczenie punktu dla wybranego N
            plot(ax, N, absError, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
            hold(ax, 'off');
    
            % Ustawienie zakresów osi
            ax.XLim = [1 maxN];
            ax.YLim = [0 errors(1)];
        catch
            resultLabel.Text = 'Błąd w obliczeniach.';
        end
    end
end

