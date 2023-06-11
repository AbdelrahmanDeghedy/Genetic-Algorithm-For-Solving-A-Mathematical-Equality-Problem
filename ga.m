% Defining the objective Function
objective_function = @(a, b, c, d) a + 2 * b + 3 * c + 4 * d - 30;

% 1. Initialization
chromosome_gens = 4;
population = 6;
Chromosome1 = {12, 5, 23, 8};
Chromosome2 = {2, 21, 18, 3};
Chromosome3 = {10, 4, 13, 14};
Chromosome4 = {20, 1, 10, 6};
Chromosome5 = {1, 4, 13, 19};
Chromosome6 = {20, 5, 17, 1};

Chromosomes = {Chromosome1; Chromosome2; Chromosome3; Chromosome4; Chromosome5; Chromosome6};

% Create a loop here
iterations = 50;
objective_values = zeros(iterations, 1); % Array to store objective function values

for iteration = 1:iterations
    % 2. Evaluation (the fitness function)
    F_obj = zeros(population, 1);
    for j = 1:population
        F_obj(j) = objective_function(Chromosomes{j}{1}, Chromosomes{j}{2}, Chromosomes{j}{3}, Chromosomes{j}{4});
    end
    
    % Store the best objective function value
    objective_values(iteration) = max(F_obj);
    
    % 3. Selection (Select the fittest chromosome)
    Fitness = zeros(population, 1);
    totalFitness = 0;
    for i = 1:population
        Fitness(i) = 1 / (1 + F_obj(i));
        totalFitness = totalFitness + Fitness(i);
    end

    % 3b. Calculation of the probability of each chromosome
    P = Fitness / totalFitness;

    % 3c. Calculations of the cumulative probabilities
    C = zeros(population, 1);
    C(1) = P(1);
    for i = 2:population
        C(i) = C(i - 1) + P(i);
    end

    % 3d. Generating random numbers R (from 0 - 1)
    R = rand(population, 1);

    % 3e. Crossover
    NewChromosomes = cell(population, 1);
    for i = 1:population
        for j = 1:population
            if (R(i) < C(j))
                NewChromosomes{i} = Chromosomes{j};
                break;
            end
        end
    end

    Chromosomes = NewChromosomes;

    % 3f. Chromosome selection
    crossover_rate = 0.25;
    crossoverIndices = find(R < crossover_rate);

    % 3g. Crossover process
    for i = 1:length(crossoverIndices)
        idx = crossoverIndices(i);
        if i == length(crossoverIndices)
            nextIdx = crossoverIndices(1);
        else
            nextIdx = crossoverIndices(i + 1);
        end

        splittingIdx = randi([1, chromosome_gens - 1]);
        Chromosomes{idx} = [Chromosomes{idx}(1:splittingIdx), Chromosomes{nextIdx}(splittingIdx + 1:end)];% indexing during crossover 
    end

    % 4. Mutation
    mutation_rate = 0.1;
    total_gen = chromosome_gens * population;
    number_of_mutations = round(mutation_rate * total_gen);
    random_indices_for_mutation = 1 + randi(total_gen, [1, number_of_mutations]) - 1;

    for i = 1:population
        for j = 1:chromosome_gens
            curr_flattened_idx = (i - 1) * chromosome_gens + j;
            if ismember(curr_flattened_idx, random_indices_for_mutation)
                newMutatedValue = randi([1, 30]);
                Chromosomes{i}{j} = newMutatedValue;
            end
        end
    end
end

% Printing the best Chromosomes
for i = 1:population
    for j = 1:chromosome_gens
        fprintf('%d ', Chromosomes{i}{j});
    end
    fprintf('\n');
end

% Plot the objective function with iterations
plot(1:iterations, objective_values);
xlabel('Iterations');
ylabel('Objective Function Value');
title('Objective Function Convergence');
