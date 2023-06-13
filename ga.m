% Defining the objective Function
objective_function = @(vec) abs(vec(1) + 2 * vec(2) + 3 * vec(3) + 4 * vec(4) - 30);

% 1. Initialization
chromosome_gens = 4;
population = 6;
Chromosome1 = [ 12, 5, 23, 8 ];
Chromosome2 = [ 2, 21, 18, 3 ];
Chromosome3 = [ 10, 4, 13, 14 ];
Chromosome4 = [ 20, 1, 10, 6 ];
Chromosome5 = [ 1, 4, 13, 19 ];
Chromosome6 = [ 20, 5, 17, 1 ];

Chromosomes = [ Chromosome1; Chromosome2; Chromosome3; Chromosome4; Chromosome5; Chromosome6 ];

iterations = 100;
objective_values = zeros(iterations, 1);

% Create a loop here
for iteration = 1 : iterations     
    % 2. Evaluation (the fitness function)
    F_obj = zeros(1, 6);
    for i = 1 : 6
        F_obj(i) = abs(objective_function(Chromosomes(i, :)));
    end

    objective_values(iteration) = min(F_obj);
    
    Fitness = zeros(1, 6);
    totalFitness = 0;
    for i = 1 : 6
        Fitness(i) = 1 / (1 + F_obj(i));
        totalFitness = totalFitness + Fitness(i);
    end

    % Calculation of the probability of each chromosome
    P = zeros(1, 6);
    for i = 1 : 6
        P(i) = Fitness(i) / totalFitness;
    end

    % Calcultions of the cumulative probabilities
    C = [P(1), 0, 0, 0, 0, 0];
    for i = 2 : 6
        C(i) = C(i - 1) + P(i);
    end

    % 3. Selection
    NewChromosomes = zeros(population, chromosome_gens);
    index = 1;
    R =rand(1, 6);
    for i = 1 : 6
        
        if   0 < R(i) && R(i) < C(1)
           NewChromosomes(i, :) = Chromosomes(1, :);
        elseif C(1) < R(i)  && R(i) < C(2)
            NewChromosomes(i, :) = Chromosomes(2, :);
        elseif C(2) < R(i) && R(i) < C(3)
            NewChromosomes(i, :) = Chromosomes(3, :);
        elseif C(3) < R(i) && R(i)< C(4)
            NewChromosomes(i, :) = Chromosomes(4, :);
        elseif C(4) < R(i)  && R(i) < C(5)
            NewChromosomes(i, :) = Chromosomes(5, :);
        elseif C(5) < R(i)  &&  R(i) < C(6)
            NewChromosomes(i, :) = Chromosomes(6, :);
        end 
    end

    Chromosomes = NewChromosomes;

    % 4. Chromosome Crossover
     crossover_rate = 0.25;
    R = rand(1, 6);

    result = zeros(population, chromosome_gens);
    r = zeros(1, population);
    parent = zeros(1, population);
    counter = 0;

    for i = 1 : population
        r(i) = rand;
        if R(i) < crossover_rate
            counter = counter + 1;
            parent(counter) = i;
        end
        result(i, :) = Chromosomes(i, :);
    end
    
    if counter > 1
        for i = 1 : counter
            cutpoint = randi([1, chromosome_gens]);
            
            if i == counter
                result(parent(i), cutpoint : chromosome_gens) = Chromosomes(parent(1), cutpoint : chromosome_gens);
            else
                result(parent(i), cutpoint : chromosome_gens) = Chromosomes(parent(i + 1), cutpoint : chromosome_gens);
            end
        end
    end
    
    
    % 5. Mutation
    mutation_rate = 0.1;
    total_gen = chromosome_gens * population;
    number_of_mutations = round(mutation_rate * total_gen);
    random_indices_for_mutation = 1 + randi(total_gen, [1, number_of_mutations]) - 1;
    
    for i = 1: length(random_indices_for_mutation)
        Chromosomes(random_indices_for_mutation(i)) = randi([1, 30]);
    end
          
end

% Printing the best Chromosomes
disp(Chromosomes);
% Plot the objective function with iterations
plot(1 : iterations, objective_values);
xlabel('Iterations');
ylabel('Objective Function Value');
title('Objective Function Convergence');
