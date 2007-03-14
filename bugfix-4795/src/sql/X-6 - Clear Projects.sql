-- Note: this script will remove all information not only about all projects,
--       but about all phases, submissions, uploads, resources, notifications,
--       automatic screening results, review, their items and comments as well.
--       You'll need to repopulate the databse with that information using
--       appropritate scripts.

DELETE screening_result;
DELETE screening_task;

DELETE review_item_comment;
DELETE review_item;
DELETE review_comment;
DELETE review;

DELETE FROM submission;
DELETE FROM upload;

DELETE FROM notification;
DELETE FROM resource_info;
DELETE FROM resource;

DELETE FROM phase_criteria;
DELETE FROM phase_dependency;
DELETE FROM project_phase;

DELETE FROM project_info;
DELETE FROM project;