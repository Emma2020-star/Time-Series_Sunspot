%Time Series
%load sunpoint data from 1986 to 2023
load vasta_data
year=SNmtotV2(:,1);
%get number of unique years C
[C,ia,ic] = unique(year);
a_counts = accumarray(ic,1);
%monthly sunpoints observations
monthly_total_sunpoints=SNmtotV2(:,4);
% number of observations too compute monthly mean
observations=SNmtotV2(:,6);
value_counts = [C, a_counts];
% Initialize an array to store annual average sunspot counts
all_averages = zeros(size(C,1),1);
%% Loop through the number of years C
for j=1:size(C,1)
     
    %loop throught the months in each individual year
    for i=1:1:size(monthly_total_sunpoints,1)
% Find indices corresponding to the current year
    indices = (year == C(j));
    % Extract monthly sunpoints for the current year
    monthly_sunpoints_for_year = monthly_total_sunpoints(indices);
    % Calculate annual sunpoint average
    annual_average_sunspot = mean(monthly_sunpoints_for_year);
    end
    %store annual_average_sunspot in all_averages array
    all_averages(j)=annual_average_sunspot;
end
%plot annual sunpoint averages on the y-axis againt the individual years
%from 1986 to 2023 on the x-axis
figure;
plot(C, all_averages, 'b', 'DisplayName', 'Rough Graph');
xlabel('Year');
ylabel('Annual Average Sunspot');
title('Annual Average Sunspot from 1986 to 2023');

% Calculate a moving average to smooth the data
window_size = 5; % Adjust this value to control the smoothing level
smoothed_data = movmean(all_averages, window_size);

% Superimpose the smoothed line on the rough data
hold on;
plot(C, smoothed_data, 'r', 'DisplayName', 'Smoothed Graph');
legend('Location', 'NorthWest');
hold off;
