Multicriteria Analysis for Energy Source Selection Using the SMART Method
PART A
Problem Definition

An energy production company plans to build a new energy production unit and needs to decide which energy sources to use. The alternative energy sources and the evaluation criteria are as follows:

Criteria:

    Cost
    Environmental Impact
    Reliability and Availability
    Efficiency (Theoretical efficiency of each alternative)
    Social and Political Aspects

Alternatives:

    Hydrogen and Biomass
    Wind Energy and Solar Energy
    Solar Energy and Natural Gas
    Biomass and Natural Gas

Management Level

The problem falls into the category of strategic planning problems. Decisions of this kind are made by the upper management level, as it affects the company both directly and long-term. Immediately, because resources (especially financial and human resources) need to be reallocated, and long-term, because creating a new energy production unit is a significant financial risk impacting the company's survival, growth, and expansion.

Stakeholders:

    Involved Entities: Municipal authorities, supplier companies, ecological organizations, communities, and end-users (company clients).
    Decision-Maker: Board of Directors.
    Decision Participants: Strategic Planning Director, Energy Systems Engineer, Financial Analyst, Environmental Consultant, Risk Management Officer, Supply Chain Manager.
    Analyst: Business Analyst, Project Manager.
    Mediator: Communication and Public Relations Consultant.

PART B
Description of the SMART Method (Simple Multi-Attribute Rating Technique)

The SMART method is a multicriteria decision-making method used to evaluate and rank alternative solutions based on multiple criteria. It is widely used due to its simplicity and ability to provide clear and understandable results. The main steps and principles of the SMART method are as follows:

    Define Criteria:
    Define the criteria that are important for evaluating the alternatives. Each criterion represents a dimension of the decision and can be quantitative or qualitative.

    Define Alternatives:
    The alternatives are the different options or solutions considered for solving the problem. Each alternative is evaluated based on the predefined criteria.

    Assign Weights to Criteria:
    Experts or decision-makers assign weights to the criteria, reflecting the relative importance of each criterion. These weights are normalized so that their sum equals 1 (or 100%).

    Evaluate Alternatives:
    For each criterion, the alternatives are evaluated, and scores are assigned representing each alternative's performance on that criterion. These scores can be objective measurements or subjective estimates from experts.

    Calculate Weighted Scores:
    The scores of each alternative for each criterion are multiplied by the respective weights of the criteria to obtain weighted scores. This allows incorporating the relative importance of each criterion into the final evaluation.

    Calculate Total Utility Value:
    The weighted scores of each alternative are summed to get the total utility value. This value represents the overall performance of each alternative based on all criteria.

    Rank Alternatives:
    The alternatives are ranked based on their total utility values in descending order. The alternative with the highest utility value is considered the best option according to the analysis.

Code Description

The provided code implements a simulation to handle missing values (NaN) and calculates the utility values for the alternatives using the SMART method. Here are the main steps of the code:

    Initialization of Criterion Values:
    Assign random values to the criteria for each expert, with a 10% probability of missing values to simulate real-world scenarios where not all information is available.

    Handling Missing Values:
    For each criterion, calculate the valid values (non-NaN) and compute their average. Replace NaN values with random values within a confidence interval of ±10% around the average.

    Normalization of Weights:
    Normalize the weights of each expert so that their sum equals 1. This is done by dividing each weight by the total weight of the respective expert.

    Setting Alternative Performances:
    Assign random performance values for each alternative, criterion, and expert. These values represent the performance of each alternative according to each criterion, as estimated by the experts.

    Calculate Utility Value of Alternatives:
    Calculate the mean weights of the criteria from the normalized weight matrices. Then, calculate the mean performances of each alternative for each criterion. The utility value of each alternative is obtained as the weighted sum of the mean performances using the mean weights of the criteria.

    Rank Alternatives:
    Finally, rank the alternatives based on their utility values in descending order. The alternatives with the highest utility values are considered the best options according to the analysis.

The function is called in the Octave terminal with the following command:

octave

[util_value, mean_performances, performances, weights, normalized_weights] = smart(5, 4, 15)

where:

    5 is the number of criteria,
    4 is the number of alternatives,
    15 is the number of experts.

Handling NaN Values

If an expert has not provided a value for a criterion, the following approach can be applied to handle the missing values (NaN):

    Confidence Interval:
    Define a confidence interval within which NaN values will be replaced.

    Valid Values:
    For each criterion, compute the valid values (non-NaN).

    Average:
    Calculate the average of the valid values.

    Replace NaN:
    Replace the NaN values with random values within the confidence interval around the average of the valid values.

PART C
Detailed Description of the Code

Our code implements a sensitivity analysis using the Monte Carlo method to examine the impact of perturbations in weights and performances on the rankings of the alternatives. Sensitivity analysis assesses the stability of the initial analysis results under various perturbations.

Steps for Sensitivity Analysis with Monte Carlo Method:

    Initialization of Parameters:
    Define the basic parameters of the problem:
        crt: Number of criteria.
        alt: Number of alternatives.
        exp: Number of experts.
        N: Number of Monte Carlo repetitions.
        util: Initial utility value.
        mean_perf: Mean performance.
        performances: Initial performances of the alternatives.
        w: Criterion weights.
        ps1, ps2, ps3: Parameters for creating perturbation strength values.

    Define Perturbation Ranges:
    Create an array s_values that defines the range of perturbation levels sss to be examined. These levels are determined by the values of ps1, ps2, and ps3.

    Monte Carlo Simulation:
    For each sss value in the s_values array:
        Initialize a counter matrix for ranking reversals for each alternative.
        Repeat N iterations of the simulation:
            Perturb weights w randomly using a uniform distribution.
            Normalize the perturbed values to maintain their sum equal to 1.
            Perturb the performances randomly.
            Calculate the mean perturbed performances.
            Rank the alternatives based on the initial and perturbed mean performances.
            Count the ranking reversals for each alternative.
        Calculate the PRR value for the current sss.
        Store the PRR values in a matrix M.

    Plot Results:
    Finally, create a chart showing the Probability of Ranking Reversal (PRR) as a function of sss for each alternative.

The function is called in the Octave terminal with the following command:

octave

    [M] = monte_carlo(5, 4, 13, 10^4, util_value, mean_performances, performances, weights, 0.2, 0.1, 0.6)

The smart(4,5,13) function must be called first to initialize the values.

This document provides a detailed explanation of the SMART method and the implementation of sensitivity analysis using Monte Carlo simulation for evaluating and ranking alternative energy sources for a new energy production unit.
