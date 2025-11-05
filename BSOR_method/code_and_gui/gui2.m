function gui2
    
    fig = figure('Name', 'Backward SOR GUI', 'NumberTitle', 'off', 'Position', [100, 100, 900, 700]);

    uicontrol('Style', 'text', 'Position', [50, 650, 200, 20], 'String', 'Wybierz przykład:');
    matrixMenu = uicontrol('Style', 'popupmenu', 'Position', [50, 620, 200, 25], ...
        'String', {'Przykład 1', 'Przykład 2', 'Przykład 3', 'Przykład 4', 'Przykład 5', 'Przykład 6', 'Przykład 7'}, ...
        'Callback', @(src, event) updateDescription(src));

   
    descriptionBox = uicontrol('Style', 'text', 'Position', [300, 620, 450, 40], ...
        'String', 'Wybierz przykład, aby zobaczyć jego opis.', 'HorizontalAlignment', 'left');

    
    uicontrol('Style', 'text', 'Position', [50, 580, 100, 20], 'String', 'Macierz A:');
    matrixABox = uicontrol('Style', 'text', 'Position', [50, 400, 300, 180], ...
        'String', '', 'HorizontalAlignment', 'left');

    uicontrol('Style', 'text', 'Position', [400, 580, 100, 20], 'String', 'Wektor b:');
    vectorBBox = uicontrol('Style', 'text', 'Position', [400, 400, 300, 180], ...
        'String', '', 'HorizontalAlignment', 'left');

    
    uicontrol('Style', 'text', 'Position', [10, 460, 220, 20], 'String', 'Zakres parametru omega:');
    omegaMin = uicontrol('Style', 'edit', 'Position', [50, 430, 60, 20], 'String', '0.01');
    omegaMax = uicontrol('Style', 'edit', 'Position', [120, 430, 60, 20], 'String', '1.99');

    uicontrol('Style', 'text', 'Position', [220, 460, 220, 20], 'String', 'Omega:');
    omega_us = uicontrol('Style', 'edit', 'Position', [300, 430, 60, 20], 'String', '1.0');

    uicontrol('Style', 'text', 'Position', [390, 460, 120, 20], 'String', 'Max iteracji:');
    ite_us = uicontrol('Style', 'edit', 'Position', [420, 430, 60, 20], 'String', '100.0');

    
    uicontrol('Style', 'text', 'Position', [10, 400, 220, 20], 'String', 'Zakres tolerancji:');
    tolMin = uicontrol('Style', 'edit', 'Position', [50, 370, 60, 20], 'String', '1e-6');
    tolMax = uicontrol('Style', 'edit', 'Position', [120, 370, 60, 20], 'String', '1e-3');

    
    uicontrol('Style', 'pushbutton', 'Position', [50, 500, 120, 30], 'String', 'Uruchom Test', ...
        'Callback', @(src, event) runBSOR(matrixMenu, omegaMin, omegaMax, tolMin, tolMax));

    
    uicontrol('Style', 'text', 'Position', [220, 400, 100, 20], 'String', 'Rozwiązanie BSOR:');
    bsorResultBox = uicontrol('Style', 'text', 'Position', [200, 380, 200, 20], ...
        'String', '', 'HorizontalAlignment', 'left');

    uicontrol('Style', 'text', 'Position', [320, 400, 200, 20], 'String', 'Rozwiązanie MATLAB (A\b):');
    matlabResultBox = uicontrol('Style', 'text', 'Position', [350, 380, 220, 20], ...
        'String', '', 'HorizontalAlignment', 'left');

    uicontrol('Style', 'text', 'Position', [490, 400, 150, 20], 'String', 'Promień spektralny B:');
    rhoBBox = uicontrol('Style', 'text', 'Position', [510, 380, 100, 20], 'String', '');
    
    uicontrol('Style', 'text', 'Position', [620, 400, 150, 20], 'String', 'Błąd względny:');
    relErrorBox = uicontrol('Style', 'text', 'Position', [590, 380, 200, 20], 'String', '');
    
    uicontrol('Style', 'text', 'Position', [730, 400, 150, 20], 'String', 'Liczba iteracji:');
    iterBox = uicontrol('Style', 'text', 'Position', [750, 380, 100, 20], 'String', '');

    
    tabGroup = uitabgroup(fig, 'Position', [0.05 0.05 0.9 0.4]);
    omegaTab = uitab(tabGroup, 'Title', 'Wykres dla Omega');
    tolTab = uitab(tabGroup, 'Title', 'Wykres dla Tolerancji');
    omegaAxes = axes('Parent', omegaTab, 'Position', [0.1, 0.2, 0.8, 0.7]);
    tolAxes = axes('Parent', tolTab, 'Position', [0.1, 0.2, 0.8, 0.7]);

    
    function updateDescription(src)
        descriptions = {
            'Przykład 1: Prosty przykład';
            'Przykład 2: Macierz źle uwarunkowana';
            'Przykład 3: Układ z dominującymi wartościami własnymi.';
            'Przykład 4: Układ bez rozwiązania (sprzeczny).';
            'Przykład 5: Układ z nieskończoną liczbą rozwiązań (niedookreślony).';
            'Przykład 6: Układ z macierzą o dużych wartościach własnych, brak dominacji diagonalnej';
            'Przykład 7: Układ z macierzą bez dominacji diagonalnej';
        };
        matrices = {
            [4, -1, 0, 0; -1, 4, -1, 0; 0, -1, 4, -1; 0, 0, -1, 3], [15; 10; 10; 10];
            [1,2; 2, 3.999], [4; 7.999];
            [1000, -1, 0, 0; -1, 1000, -1, 0; 0, -1, 1000, -1; 0, 0, -1, 1000], [1000; 1000; 1000; 1000];
            [1, 2; 2, 4], [5; 12];  
            [1, 2, 3; 2, 4, 6; 1,2, 3], [6; 12; 6];  
            [2,3;5,4], [5,;6];
            [1,3;4,1], [7;10];
        };

        selectedIndex = get(src, 'Value');
        set(descriptionBox, 'String', descriptions{selectedIndex});
        
        % Wyświetlanie macierzy A
        A = matrices{selectedIndex, 1};
        A_str = sprintf('%s\n', mat2str(A));
        set(matrixABox, 'String', A_str);

        % Wyświetlanie wektora b
        b = matrices{selectedIndex, 2};
        b_str = sprintf('%s\n', mat2str(b));
        set(vectorBBox, 'String', b_str);
    end

    % Funkcja uruchamiająca test BSOR i wyświetlająca wyniki
    function runBSOR(matrixMenu, omegaMin, omegaMax, tolMin, tolMax)
        matrices = {
            [4, -1, 0, 0; -1, 4, -1, 0; 0, -1, 4, -1; 0, 0, -1, 3], [15; 10; 10; 10];
            [1,2; 2, 3.999], [4; 7.999];
            [1000, -1, 0, 0; -1, 1000, -1, 0; 0, -1, 1000, -1; 0, 0, -1, 1000], [1000; 1000; 1000; 1000];
            [1, 2; 2, 4], [5; 12];
            [1, 2, 3; 2, 4, 6; 1,2, 3], [6; 12; 6];
            [2,3;5,4], [5,;6];
            [1,3;4,1], [7;10];
        };

        selectedIndex = get(matrixMenu, 'Value');
        A = matrices{selectedIndex, 1};
        b = matrices{selectedIndex, 2};

        omega_min = str2double(get(omegaMin, 'String'));
        omega_max = str2double(get(omegaMax, 'String'));
        omega_values = omega_min:0.01:omega_max;

        tol_min = str2double(get(tolMin, 'String'));
        tol_max = str2double(get(tolMax, 'String'));
        tol_values = logspace(log10(tol_min), log10(tol_max), 10);

        num_omegas = length(omega_values);
        iterations_omega = zeros(1, num_omegas);
        iterations_tol = zeros(1, length(tol_values));

        tol = 1e-6;
        ite_uss = str2double(get(ite_us, 'String'));
        max_iter = ite_uss;
        omega_uss = str2double(get(omega_us, 'String'));
        [x_bsor, iter_fixed, rho_B, rel_error] = BSOR2(A, b, omega_uss, tol, max_iter, zeros(size(b)));

       tol = 1e-12; 
        rank_A = rank(A, tol);     
        rank_A_augmented = rank([A b], tol); 
        
        n = size(A, 2); 
        
        if rank_A < rank_A_augmented
            x_matlab = NaN;
        elseif rank_A == rank_A_augmented && rank_A < n
            x_matlab = inf;
        else
    
            x_matlab = A \ b;
           
        end


        set(bsorResultBox, 'String', sprintf('%.4f ', x_bsor));
        set(matlabResultBox, 'String', sprintf('%.4f ', x_matlab));
        set(rhoBBox, 'String', sprintf('%.4f', rho_B));
        set(relErrorBox, 'String', sprintf('%.4e', rel_error));
        set(iterBox, 'String', sprintf('%d', iter_fixed));

        for idx = 1:num_omegas
            omega = omega_values(idx);
            [~, iter] = BSOR(A, b, omega, tol, max_iter, zeros(size(b)));
            iterations_omega(idx) = iter;
        end

        for idx = 1:length(tol_values)
            tol = tol_values(idx);
            [~, iter] = BSOR(A, b, omega_uss, tol, max_iter, zeros(size(b)));
            iterations_tol(idx) = iter;
        end

        axes(omegaAxes);
        plot(omega_values, iterations_omega, '-o', 'LineWidth', 1.5);
        hold on;
        xlabel('\omega (Parametr relaksacji)');
        ylabel('Liczba iteracji');
        title('Backward SOR: Liczba iteracji vs. \omega');
        grid on;
        hold off;

        axes(tolAxes);
        plot(tol_values, iterations_tol, '-o', 'LineWidth', 1.5);
        xlabel('Tolerancja');
        ylabel('Liczba iteracji');
        title('Backward SOR: Liczba iteracji vs. Tolerancja dla \omega = 1');
        grid on;
    end
end
