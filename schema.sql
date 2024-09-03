-- Makes a relational database of friends representing a collection of rooted tree-structure graphs with users and their friends

-- Makes a table of users in the database
CREATE TABLE "users" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Makes a table of friends in the database
CREATE TABLE "friends" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Makes a table of subjects referenced by a table of work
CREATE TABLE "subjects" (
    "id" INTEGER,
    "title" TEXT NOT NULL UNIQUE,
    "description" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Makes a table of work that friends do for their profession
CREATE TABLE "work" (
    "id" INTEGER,
    "title" TEXT NOT NULL UNIQUE,
    "subject_id" INTEGER,
    "description" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("subject_id") REFERENCES "subjects"("id")
);

-- Makes a table of professions that friends do
CREATE TABLE "professions" (
    "friend_id" INTEGER,
    "work_id" INTEGER,
    FOREIGN KEY("friend_id") REFERENCES "friends"("id"),
    FOREIGN KEY("work_id") REFERENCES "work"("id")
);

-- Makes a table of hobbies that friends do for fun
CREATE TABLE "hobbies" (
    "id" INTEGER,
    "title" TEXT NOT NULL UNIQUE,
    "description" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Makes a table of activities that friends part in
CREATE TABLE "activities" (
    "friend_id" INTEGER,
    "hobby_id" INTEGER,
    FOREIGN KEY("friend_id") REFERENCES "friends"("id"),
    FOREIGN KEY("hobby_id") REFERENCES "hobbies"("id")
);

-- Makes a table of skills that are associated with work
CREATE TABLE "skills" (
    "work_id" INTEGER,
    "title" TEXT NOT NULL UNIQUE,
    "description" TEXT NOT NULL,
    FOREIGN KEY("work_id") REFERENCES "work"("id")
);

-- Makes a table of achievements that friends do
CREATE TABLE "achievements" (
    "friend_id" INTEGER,
    "title" TEXT NOT NULL UNIQUE,
    "description" TEXT NOT NULL,
    FOREIGN KEY("friend_id") REFERENCES "friends"("id")
);

-- Makes a table of relations that users have with friends
CREATE TABLE "relations" (
    "user_id" INTEGER,
    "friend_id" INTEGER,
    "relation" TEXT NOT NULL,
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("friend_id") REFERENCES "friends"("id")
);

-- Makes a table of dates that users have interacted with friends
CREATE TABLE "contact" (
    "user_id" INTEGER,
    "friend_id" INTEGER,
    "date_of_interaction" DATE NOT NULL,
    "description" TEXT NOT NULL,
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("friend_id") REFERENCES "friends"("id")
);

-- Makes a table of relationships between friends
CREATE TABLE "relationships" (
    "friend0_id" INTEGER,
    "friend1_id" INTEGER,
    "relation" TEXT NOT NULL,
    FOREIGN KEY("friend0_id") REFERENCES "friends"("id"),
    FOREIGN KEY("friend1_id") REFERENCES "friends"("id")
);

-- Makes a view that displays relations with friends
CREATE VIEW "friends_relations" AS
SELECT "users"."first_name", "users"."last_name", "friends"."first_name", "friends"."last_name", "relation"
FROM  "users" JOIN "relations" ON "users"."id" = "relations"."user_id"
JOIN "friends" ON "relations"."friend_id" = "friends"."id";

-- Makes a view that displays the names and work of friends
CREATE VIEW "friends_work" AS
SELECT "first_name", "last_name", "title"
FROM "friends" JOIN "professions" ON "friends"."id" = "professions"."work_id"
JOIN "work" ON "professions"."work_id" = "work"."id";

-- Makes a view that displays the names and hobbies of friends
CREATE VIEW "friends_hobbies" AS
SELECT "first_name", "last_name", "title"
FROM "friends" JOIN "activities" ON "friends"."id" = "activities"."friend_id"
JOIN "hobbies" ON "activities"."hobby_id" = "hobbies"."id";
