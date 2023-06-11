% Defining the objective Function
objective_function = @(a, b, c, d) a + 2 * b + 3 * c + 4 * d - 30;

% 1. Initialization
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
crossover_rate = 0.25;

for i = 1 : 6
    for j = 1 : 6
        if(R{i} < C{j})
            NewChromosomes{i} = Chromosomes{j};
            break;
        end
    end
end
NewChromosomes = Chromosomes;

disp(NewChromosomes);

% 3f. Chromosome selection point

% 4. Mutation


