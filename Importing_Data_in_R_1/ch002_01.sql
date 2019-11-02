-- !preview conn=con

-- select tweat_id from comments where user_id = 1;

-- select post from tweats where date > '2015-09-21';


SELECT post, message
  FROM tweats INNER JOIN comments on tweats.id = tweat_id
    WHERE tweat_id = 77;