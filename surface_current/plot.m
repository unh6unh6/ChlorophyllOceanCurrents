function plotData(data, edges)
    % plotHistogramByRange - 각 열에 대해 지정된 범위로 히스토그램을 그리고 서브플롯으로 표시합니다.
    % data: 2차원 행렬 (MxN)
    % edges: 히스토그램 구간 경계 값 벡터 (1xP)

    % 데이터 크기 확인
    [numRows, numCols] = size(data);

    % 서브플롯으로 각 열의 히스토그램 그리기
    figure;
    numBins = length(edges) - 1;

    for i = 1:numCols
        subplot(numCols, 1, i);
        col_data = data(:, i);
        histogram(col_data, 'BinEdges', edges, 'FaceColor', 'b');
        xlabel(sprintf('Range %d-%d', edges(1), edges(end)));
        ylabel('Frequency');
        title(sprintf('Column %d', i));
        xlim([edges(1) edges(end)]);
    end

    % 그래프 간의 간격 조정
    set(gcf, 'Position', [100, 100, 600, 800]);  % 그래프 크기 조정
end
