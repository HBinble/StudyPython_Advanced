-- 2day

-- 회원정보 전체 조회

SELECT * 
    FROM member ;

-- 취미가 수영인 회원들 중에 마일리지의 값이 1000 이상인 
-- 회원아이디, 회원이름, 회원취미, 회원마일리지 조회
-- 정렬은 회원이름 기준 오름차순

SELECT mem_id, mem_name, mem_like, mem_mileage
    FROM member
        WHERE mem_mileage >= 1000
            ORDER BY mem_name ASC;