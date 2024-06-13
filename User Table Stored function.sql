drop function UserProc;
CREATE OR REPLACE FUNCTION UserProc(
    action VARCHAR,
    user_name VARCHAR DEFAULT NULL,
    user_email VARCHAR DEFAULT NULL,
    user_password VARCHAR DEFAULT NULL,
    user_photo VARCHAR DEFAULT NULL,
    user_address VARCHAR DEFAULT NULL,
    state_id INT DEFAULT NULL,
    country_id INT DEFAULT NULL,
    user_id INT DEFAULT NULL  -- Added for update and delete operations
)
RETURNS TABLE (
    uid INT,
    name VARCHAR,
    email VARCHAR,
    password VARCHAR,
    photo VARCHAR,
    address VARCHAR,
    sid INT,
    cid INT,
    rows_affected INT  -- To return the number of rows affected for update and delete operations
) AS $$
BEGIN
    IF action = 'select' THEN
        RETURN QUERY SELECT u.uid, u.name, u.email, u.password, u.photo, u.address, u.sid, u.cid, NULL::INT AS rows_affected 
                     FROM UserTbl u
                     WHERE u.isdelete = 'No'
                     ORDER BY u.uid;
    ELSIF action = 'insert' THEN
        INSERT INTO UserTbl (name, email, password, photo, address, sid, cid, isdelete)
        VALUES (user_name, user_email, user_password, user_photo, user_address, state_id, country_id, 'No');
        
        -- Return only the latest uid
        RETURN QUERY SELECT currval(pg_get_serial_sequence('UserTbl', 'uid'))::INT AS uid, 
                             NULL::VARCHAR AS name, 
                             NULL::VARCHAR AS email, 
                             NULL::VARCHAR AS password, 
                             NULL::VARCHAR AS photo, 
                             NULL::VARCHAR AS address, 
                             NULL::INT AS sid, 
                             NULL::INT AS cid,
                             NULL::INT AS rows_affected;
    ELSIF action = 'update' THEN
        UPDATE UserTbl
        SET name = COALESCE(user_name, UserTbl.name),
            email = COALESCE(user_email, UserTbl.email),
            password = COALESCE(user_password, UserTbl.password),
            photo = COALESCE(user_photo, UserTbl.photo),
            address = COALESCE(user_address, UserTbl.address),
            sid = COALESCE(state_id, UserTbl.sid),
            cid = COALESCE(country_id, UserTbl.cid)
        WHERE UserTbl.uid = user_id;
        
        -- Return the number of rows affected
        GET DIAGNOSTICS rows_affected = ROW_COUNT;
        RETURN QUERY SELECT user_id, NULL::VARCHAR AS name, NULL::VARCHAR AS email, NULL::VARCHAR AS password, 
                             NULL::VARCHAR AS photo, NULL::VARCHAR AS address, NULL::INT AS sid, NULL::INT AS cid, 
                             rows_affected AS rows_affected;
    ELSIF action = 'delete' THEN
        -- Logical delete by updating isdelete column
        UPDATE UserTbl
        SET isdelete = 'Yes'
        WHERE UserTbl.uid = user_id;
        
        -- Return the number of rows affected
        GET DIAGNOSTICS rows_affected = ROW_COUNT;
        RETURN QUERY SELECT user_id, NULL::VARCHAR AS name, NULL::VARCHAR AS email, NULL::VARCHAR AS password, 
                             NULL::VARCHAR AS photo, NULL::VARCHAR AS address, NULL::INT AS sid, NULL::INT AS cid, 
                             rows_affected AS rows_affected;
    ELSE
        RAISE EXCEPTION 'Invalid action parameter: %', action;
    END IF;
END;
$$ LANGUAGE plpgsql;



-- To select all users
SELECT * FROM UserProc('select');

-- To insert a new user and get the latest inserted uid
SELECT * FROM UserProc(
    'insert', 
    'John Doe jr. 4.0', 
    'johnjr3.doe@example.com', 
    'securepassword3', 
    'john3.jpg', 
    '12345 Main St', 
    3,  -- state_id
    4   -- country_id
);

-- To update a user and get the number of rows affected
SELECT * FROM UserProc(
    'update', 
    'John Updated2', 
    'john.updated@example.com', 
    'newpassword', 
    'john_updated.jpg', 
    '456 Updated St', 
    2,  -- new state_id
    2,  -- new country_id
    3   -- user_id to update
);

-- To delete a user and get the number of rows affected
SELECT * FROM UserProc(
    'delete', 
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    NULL,
    2   -- user_id to delete
);

truncate table UserTbl restart identity;
select * from UserTbl;