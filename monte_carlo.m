function M = monte_carlo(crt, alt, exp, N, util, mean_perf, performances, w, ps1, ps2, ps3)
    % Αρχικοποίηση παραμέτρων
    criterias = crt;          % Αριθμός κριτηρίων
    alternatives = alt;       % Αριθμός εναλλακτικών
    experts = exp;            % Αριθμός ειδικών
    num_iterations = N;       % Αριθμός επαναλήψεων Monte Carlo
    util_value_initial = util;% Αρχική τιμή χρησιμότητας
    mean_performances = mean_perf; % Μέσες αποδόσεις
    weights = w;              % Βάρη

    % Ισχύς διαταραγμάτων
    s_values = ps1:ps2:ps3;   % Εύρος ισχύος διαταραγμάτων
    PRR = zeros(length(s_values), alternatives); % Πίνακας για τις τιμές PRR

    % Προσομοίωση Monte Carlo για ανάλυση ευαισθησίας
    for idx = 1:length(s_values)
        s = s_values(idx);  % Τρέχουσα ισχύς διαταραγμάτων
        reversals_count = zeros(alternatives, 1);  % Μετρητής αντιστροφών για κάθε εναλλακτική

        % Εκτέλεση προσομοιώσεων Monte Carlo
        for n = 1:num_iterations
            % Διαταραχή βαρών με ομοιόμορφη κατανομή
            perturbed_weights = weights .* (1 + s * (rand(size(weights)) - 0.5));
            perturbed_weights = perturbed_weights ./ sum(perturbed_weights);  % Κανονικοποίηση διαταραγμένων βαρών

            % Διαταραχή αποδόσεων με ομοιόμορφη κατανομή
            perturbed_performances = performances .* (1 + s * (rand(size(performances)) - 0.5));

            % Υπολογισμός μέσης διαταραγμένης απόδοσης
            mean_perturbed_performance = mean(perturbed_performances, 3);

            % Υπολογισμός τιμών χρησιμότητας με διαταραγμένα βάρη
            util_value_perturbed = zeros(alternatives, 1);
            for i = 1:alternatives
                util_value_perturbed(i) = sum(perturbed_weights(:, i) .* mean_perturbed_performance(:, i));
            end

            % Μετρητής αντιστροφών κατάταξης
            for i = 1:alternatives
                if util_value_initial(i) > util_value_perturbed(i)
                    reversals_count(i) = reversals_count(i) + 1;
                end
            end
        end

        % Υπολογισμός PRR για την τρέχουσα ισχύ διαταραγμάτων
        PRR(idx, :) = reversals_count' / (num_iterations * alternatives);

        % Εμφάνιση τιμών PRR για κάθε εναλλακτική και ισχύ διαταραγμάτων
        fprintf('PRR για την ισχύ διαταραγμάτων s = %.2f:\n', s);
        disp(PRR(idx, :));
    end

    M = PRR;  % Επιστροφή του πίνακα PRR

    % Εμφάνιση συνολικών αντιστροφών κατάταξης
    total_reversals = sum(reversals_count);
    fprintf('Συνολικές αντιστροφές κατάταξης για κάθε εναλλακτική:\n');
    disp(total_reversals);

    % Εμφάνιση συνολικού αριθμού διαταραγμάτων
    total_perturbations = num_iterations * alternatives * length(s_values);
    fprintf('Συνολικός αριθμός διαταραγμάτων:\n');
    disp(total_perturbations);

    % Σχεδίαση PRR ως συνάρτηση της ισχύος διαταραγμάτων
    figure;
    hold on;
    colors = {'r', 'g', 'b', 'k'};  % Διαφορετικά χρώματα για κάθε εναλλακτική
    markers = {'o', 's', 'd', '^'}; % Διαφορετικά σύμβολα για κάθε εναλλακτική
    for i = 1:alternatives
        plot(s_values, PRR(:, i), '-o', 'Color', colors{i}, 'Marker', markers{i}, 'LineWidth', 1.5, ...
             'MarkerSize', 6, 'DisplayName', sprintf('Εναλλακτική %d', i));
            xlabel('Ισχύς Διαταραγμάτων (s)');
            ylabel('Πιθανότητα Αντιστροφής Κατάταξης (PRR)');
            title('Ανάλυση Ευαισθησίας με Προσομοίωση Monte Carlo');
            legend('Location', 'Best');
            xlim([min(s_values)-0.1, max(s_values)+0.1]);  % Ρύθμιση ορίων του x-άξονα
            ylim([0, 1]);  % Εξασφάλιση ότι ο y-άξονας καλύπτει το εύρος από 0 έως 1
    end
    grid on;
    hold off;
end


