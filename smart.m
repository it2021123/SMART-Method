%------------------------------------------------------------
function [util_value, mean_performances, performances, weights, normalized_weights] = smart(criterias, alternatives, experts)
    % Βήμα 1: Ορισμός των τιμών των κριτηρίων σύμφωνα με τους εμπειρογνώμονες
    weights = zeros(criterias, experts);   % Αρχικοποίηση του πίνακα βαρών
    for i = 1:experts
        for j = 1:criterias
            % Προσομοίωση μερικών ελλειπόντων τιμών (υποθέτουμε 10% ελλειπτικά)
            if rand() < 0.1
                weights(j, i) = NaN;  % Ανάθεση NaN για προσομοίωση ελλείπουσας τιμής
            else
                % Ανάθεση τυχαίων τιμών στα κριτήρια για προσομοίωση των εμπειρογνωμόνων
                % Οι τιμές κυμαίνονται μεταξύ 10 και 100
                weights(j, i) = randi([10, 100]);
            end
        end
    end

    confidence_interval = 0.1;  % Διάστημα εμπιστοσύνης
    for j = 1:criterias
        % Βρίσκουμε τις έγκυρες τιμές για το τρέχον κριτήριο (εξαιρώντας τα NaN)
        valid_weights = weights(j, ~isnan(weights(j, :)));

        % Υπολογισμός μέσου όρου των έγκυρων τιμών
        mean_weight = mean(valid_weights);

        % Αντικατάσταση των NaN με τυχαίο αριθμό εντός του διαστήματος εμπιστοσύνης
        nan_indices = isnan(weights(j, :));
        num_nans = sum(nan_indices);

        % Τυχαίοι αριθμοί στο διάστημα [mean_weight - interval, mean_weight + interval]
        random_values = mean_weight + (2*rand(1, num_nans) - 1) * confidence_interval * mean_weight;

        % Αντικατάσταση των NaN με τους τυχαίους αριθμούς
        weights(j, nan_indices) = random_values;
    end

    % Κανονικοποίηση των βαρών μετά την αντιμετώπιση των ελλειπουσών τιμών
    normalized_weights = zeros(criterias, experts);   % Αρχικοποίηση του πίνακα κανονικοποιημένων βαρών
    for i = 1:experts
        total_weight = sum(weights(:, i));   % Υπολογισμός του συνολικού βάρους για κάθε εμπειρογνώμονα
        for j = 1:criterias
            % Κανονικοποίηση κάθε βάρους δια της συνολικής τιμής του εμπειρογνώμονα
            normalized_weights(j, i) = weights(j, i) / total_weight;
        end
    end

    % Βήμα 4: Ορισμός της απόδοσης των εναλλακτικών ανά κριτήριο ανά εμπειρογνώμονα
    performances = zeros(criterias, alternatives, experts);   % Αρχικοποίηση του πίνακα αποδόσεων
    for i = 1:experts
        for j = 1:alternatives
            for k = 1:criterias
                % Προσομοίωση των αποδόσεων αναθέτοντας τυχαίες τιμές
                % Οι τιμές κυμαίνονται μεταξύ 10 και 100
                performances(k, j, i) = randi([10, 100]);
            end
        end
    end

    % Βήμα 5: Υπολογισμός της τιμής χρησιμότητας των εναλλακτικών
    util_value = zeros(alternatives, 1);     % Αρχικοποίηση του πίνακα τιμών χρησιμότητας
    mean_weights = zeros(criterias, 1);      % Αρχικοποίηση του πίνακα μέσων βαρών
    mean_performances = zeros(criterias, 1); % Αρχικοποίηση του πίνακα μέσων αποδόσεων

    % Υπολογισμός των μέσων βαρών για κάθε κριτήριο
    for i = 1:criterias
        mean_weights(i) = mean(normalized_weights(i, :));
    end

    % Υπολογισμός των τιμών χρησιμότητας για κάθε εναλλακτική
    for i = 1:alternatives
        for j = 1:criterias
            % Υπολογισμός της μέσης απόδοσης κάθε εναλλακτικής για κάθε κριτήριο
            mean_performances(j) = mean(performances(j, i, :));
        end
        % Υπολογισμός της τιμής χρησιμότητας της εναλλακτικής ως το σταθμισμένο άθροισμα των μέσων αποδόσεων
        util_value(i) = sum(mean_weights .* mean_performances);
    end

    % Βήμα 6: Ταξινόμηση των εναλλακτικών
    [sorted_util_value, sorted_indices] = sort(util_value, 'descend');   % Ταξινόμηση των τιμών χρησιμότητας κατά φθίνουσα σειρά

    % Εμφάνιση των ταξινομημένων τιμών χρησιμότητας και των αντίστοιχων εναλλακτικών
    disp('Sorted Utility Values and Corresponding Alternatives:');
    for i = 1:alternatives
        fprintf('Alternative %d: Utility Value = %.2f\n', sorted_indices(i), sorted_util_value(i));
    end
end





