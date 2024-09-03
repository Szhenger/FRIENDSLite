-- Populates the database with sample data

-- Insert user entities
INSERT INTO "users"
    ("first_name", "last_name")
VALUES
    ('Shuo', 'Zheng'),
    ('Bryce', 'Malan'),
    ('Sam', 'Yu'),
    ('Carter', 'Cable');

-- Insert friend entities
INSERT INTO "friends"
    ("first_name", "last_name")
VALUES
    ('Hannah', 'Zenke'),
    ('Cal', 'Wheeler'),
    ('Erik', 'Oliver'),
    ('Jason', 'Solomon');

-- Insert relation edge for Shuo Zheng and Jason Solomon
INSERT INTO "relations"
    ("user_id", "friend_id", "relation")
SELECT "users"."id", "friends"."id", "Best Friends"
FROM "users", "friends"
WHERE ("users"."first_name" = 'Shuo' AND "users"."last_name" = 'Zheng')
AND ("friends"."first_name" = 'Jason' AND "friends"."last_name" = 'Solomon');

-- Insert subject entities
INSERT INTO "subjects"
    ("title", "description")
VALUES
    ('Mathematics', 'Foo'),
    ('Computer Science', 'Bar'),
    ('Engineering', 'Baz');

-- Insert work entity for Professor
INSERT INTO "work"
    ("title", "subject_id", "description")
SELECT "Professor", "id", "CS50"
FROM "subjects" WHERE "title" = 'Computer Science';

-- Insert profession edge for Jason
INSERT INTO "professions"
    ("friend_id", "work_id")
SELECT "friends"."id", "work"."id"
FROM "friends", "work"
WHERE ("friends"."first_name" = 'Jason' AND "friends"."last_name" = 'Solomon')
AND ("work"."title" = 'Professor');

-- Insert hobby entities
INSERT INTO "hobbies"
    ("title", "description")
VALUES
    ('Reading', 'Books'),
    ('Sewing', 'Clothes'),
    ('Anime', 'Life'),
    ('Sports', 'Pickle Ball');

-- Insert hobby edge for Hannah
INSERT INTO "activities"
    ("friend_id", "hobby_id")
SELECT "friends"."id", "hobbies"."id"
FROM "friends", "hobbies"
WHERE ("friends"."first_name" = 'Hannah' AND "friends"."last_name" = 'Zenke')
AND ("hobbies"."title" = 'Anime');

