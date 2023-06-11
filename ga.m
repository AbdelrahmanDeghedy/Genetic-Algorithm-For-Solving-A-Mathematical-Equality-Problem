% Defining the objective Function
objective_function = @(a, b, c, d) a + 2 * b + 3 * c + 4 * d - 30;

% 1. Initialization
chromosome_gens = 4;
population = 6;
Chromosome1 = { 12, 5, 23, 8 };
Chromosome2 = { 2, 21, 18, 3 };
Chromosome3 = { 10, 4, 13, 14 };
Chromosome4 = { 20, 1, 10, 6 };
Chromosome5 = { 1, 4, 13, 19 };
Chromosome6 = { 20, 5, 17, 1 };

Chromosomes = { Chromosome1; Chromosome2; Chromosome3; Chromosome4; Chromosome5; Chromosome6 };

% Create a loop here

% 2. Evaluation (the fitness function)
F_obj = {0, 0, 0, 0, 0, 0};
for i = 1 : 6
    F_obj{i} = objective_function(Chromosomes{i}{1}, Chromosomes{i}{2}, Chromosomes{i}{3}, Chromosomes{i}{4});
end

% 3. Selection (Select the fittest chromosome)
Fitness = {0, 0, 0, 0, 0, 0};
totalFitness = 0;
for i = 1 : 6
    Fitness{i} = 1 / (1 + F_obj{i});
    totalFitness = totalFitness + Fitness{i};
end

% 3b. Calculation of the probability of each chromosome
P = {0, 0, 0, 0, 0, 0};
for i = 1 : 6
    P{i} = Fitness{i} / totalFitness;
end

% 3c. Calcultions of the cumulative probabilities
C = {P{1}, 0, 0, 0, 0, 0};
for i = 2 : 6
    C{i} = C{i - 1} + P{i};
end

% 3d. Generating random numbers R (from 0 - 1)
R = {0, 0, 0, 0, 0, 0};
for i = 1 : 6
    R{i} = rand;
end

% 3e. Crossover
NewChromosomes = {0, 0, 0, 0, 0, 0};
for i = 1 : 6
    for j = 1 : 6
        if(R{i} < C{j})
            NewChromosomes{i} = Chromosomes{j};
            break;
        end
    end
end

Chromosomes = NewChromosomes;

% 3f. Chromosome selection
crossover_rate = 0.25;
crossoverIndices = [];
for i = 1 : 6
    if(R{i} < crossover_rate)
        crossoverIndices = [crossoverIndices, i];
    end
end

% 3g. crossover process
for i = 1 : length(crossoverIndices)
    idx = crossoverIndices(i);
    if i == length(crossoverIndices)
        nextIdx = 1;
    else 
        nextIdx = crossoverIndices(i + 1);
    end
    
    splittingIdx = randi([1, 3]);
    Chromosomes{idx} = [ Chromosomes{idx}(1 : splittingIdx), Chromosomes{nextIdx}(splittingIdx + 1: chromosome_gens ) ];
end

% 4. Mutation
mutation_rate = 0.1;
total_gen = chromosome_gens * population;
number_of_mutations = round(mutation_rate * total_gen);
random_indices_for_mutation = 1 + randi(total_gen, [1, number_of_mutations]) - 1;

for i = 1 : population
    for j = 1 : chromosome_gens
        curr_flattened_idx = i * chromosome_gens + j;
        if find(curr_flattened_idx == random_indices_for_mutation)
            newMutatedValue = randi([1, 30]);
            Chromosomes{i}{j} = newMutatedValue;
        end
    end
end


