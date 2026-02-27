-- ============================================
-- 지역별 사회경제적 취약성 및 범죄 데이터 모델 설계
-- ============================================

-- 1. 지역 차원 테이블
CREATE TABLE dim_region (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL,
    region_code VARCHAR(20),
    administrative_level VARCHAR(50)
);

-- 2. 연도 차원 테이블
CREATE TABLE dim_year (
    year_id INT PRIMARY KEY,
    year INT NOT NULL UNIQUE
);

-- 3. 복지 지표 Fact 테이블
CREATE TABLE fact_welfare (
    region_id INT NOT NULL,
    year_id INT NOT NULL,
    basic_livelihood_cnt INT,
    welfare_ratio FLOAT,
    PRIMARY KEY (region_id, year_id),
    FOREIGN KEY (region_id) REFERENCES dim_region(region_id),
    FOREIGN KEY (year_id) REFERENCES dim_year(year_id)
);

-- 4. 범죄 지표 Fact 테이블
CREATE TABLE fact_crime (
    region_id INT NOT NULL,
    year_id INT NOT NULL,
    total_crime_cnt INT,
    crime_rate FLOAT,
    PRIMARY KEY (region_id, year_id),
    FOREIGN KEY (region_id) REFERENCES dim_region(region_id),
    FOREIGN KEY (year_id) REFERENCES dim_year(year_id)
);

-- ============================================
-- 인덱스 설계
-- ============================================

CREATE INDEX idx_welfare_region_year 
ON fact_welfare(region_id, year_id);

CREATE INDEX idx_crime_region_year 
ON fact_crime(region_id, year_id);
