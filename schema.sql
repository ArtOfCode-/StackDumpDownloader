-- Schema creation SQL designed for MySQL systems.

CREATE TABLE IF NOT EXISTS `Badges` (
    `Id` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `SiteSpecificId` INT(11) NOT NULL,
    `UserId` INT(11) NOT NULL,
    `Name` VARCHAR(50) NOT NULL,
    `Date` DATETIME NOT NULL,
    `Class` TINYINT(1) NOT NULL,
    `TagBased` BOOLEAN NOT NULL,
    `Site` VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Comments` (
    `Id` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `SiteSpecificId` INT(11) NOT NULL,
    `PostId` INT(11) NOT NULL,
    `Score` INT(11) NOT NULL,
    `Text` VARCHAR(500) NOT NULL,
    `CreationDate` DATETIME NOT NULL,
    `UserId` INT(11) NOT NULL,
    `UserDisplayName` VARCHAR(100),
    `Site` VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `PostHistory` (
    `Id` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `SiteSpecificId` INT(11) NOT NULL,
    `PostHistoryTypeId` INT(11) NOT NULL,
    `PostId` INT(11) NOT NULL,
    `RevisionGUID` VARCHAR(40) NOT NULL,
    `CreationDate` DATETIME NOT NULL,
    `UserDisplayName` VARCHAR(100),
    `Comment` VARCHAR(500),
    `UserId` INT(11),
    `Text` VARCHAR(30000),
    `Site` VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `PostLinks` (
    `Id` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `SiteSpecificId` INT(11) NOT NULL,
    `CreationDate` DATETIME NOT NULL,
    `PostId` INT(11) NOT NULL,
    `RelatedPostId` INT(11) NOT NULL,
    `LinkTypeId` INT(11) NOT NULL,
    `Site` VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Posts` (
    `Id` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `SiteSpecificId` INT(11) NOT NULL,
    `PostTypeId` INT(11) NOT NULL,
    `ParentId` INT(11),
    `AcceptedAnswerId` INT(11),
    `CreationDate` DATETIME NOT NULL,
    `Score` INT(11) NOT NULL,
    `ViewCount` INT(11),
    `Body` VARCHAR(30000) NOT NULL,
    `OwnerUserId` INT(11) NOT NULL,
    `OwnerDisplayName` VARCHAR(100),
    `LastEditorUserId` INT(11),
    `LastEditorDisplayName` VARCHAR(100),
    `LastEditDate` DATETIME,
    `LastActivityDate` DATETIME,
    `Title` VARCHAR(120),
    `Tags` VARCHAR(140),
    `AnswerCount` INT(11),
    `CommentCount` INT(11),
    `FavoriteCount` INT(11),
    `ClosedDate` DATETIME,
    `CommunityOwnedDate` DATETIME,
    `Site` VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Tags` (
    `Id` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `SiteSpecificId` INT(11) NOT NULL,
    `TagName` VARCHAR(25) NOT NULL,
    `Count` INT(11) NOT NULL,
    `ExcerptPostId` INT(11) NOT NULL,
    `WikiPostId` INT(11) NOT NULL,
    `Site` VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Users` (
    `Id` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `SiteSpecificId` INT(11) NOT NULL,
    `Reputation` INT(11) NOT NULL,
    `CreationDate` DATETIME NOT NULL,
    `DisplayName` VARCHAR(100) NOT NULL,
    `LastAccessDate` DATETIME,
    `Location` VARCHAR(100),
    `AboutMe` VARCHAR(30000),
    `Views` INT(11) NOT NULL,
    `UpVotes` INT(11) NOT NULL,
    `DownVotes` INT(11) NOT NULL,
    `Age` INT(3),
    `AccountId` INT(11) NOT NULL,
    `ProfileImageUrl` VARCHAR(255),
    `WebsiteUrl` VARCHAR(255),
    `Site` VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Votes` (
    `Id` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `SiteSpecificId` INT(11) NOT NULL,
    `PostId` INT(11) NOT NULL,
    `VoteTypeId` INT(11) NOT NULL,
    `UserId` INT(11),
    `CreationDate` DATETIME NOT NULL,
    `BountyAmount` INT(11),
    `Site` VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `PostHistoryTypes` (
    `Id` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(30) NOT NULL
);
INSERT INTO `PostHistoryTypes` (`Id`, `Name`) VALUES
    (1, 'Initial Title'),
    (2, 'Initial Body'),
    (3, 'Initial Tags'),
    (4, 'Edit Title'),
    (5, 'Edit Body'),
    (6, 'Edit Tags'),
    (7, 'Rollback Title'),
    (8, 'Rollback Body'),
    (9, 'Rollback Tags'),
    (10, 'Post Closed'),
    (11, 'Post Reopened'),
    (12, 'Post Deleted'),
    (13, 'Post Undeleted'),
    (14, 'Post Locked'),
    (15, 'Post Unlocked'),
    (16, 'Community Owned'),
    (17, 'Post Migrated'),
    (18, 'Question Merged'),
    (19, 'Question Protected'),
    (20, 'Question Unprotected'),
    (22, 'Question Unmerged'),
    (24, 'Suggested Edit Applied'),
    (25, 'Post Tweeted'),
    (31, 'Discussion moved to chat'),
    (33, 'Post Notice Added'),
    (34, 'Post Notice Removed'),
    (35, 'Post Migrated Away'),
    (36, 'Post Migrated Here'),
    (37, 'Post Merge Source'),
    (38, 'Post Merge Destination');
    
CREATE TABLE IF NOT EXISTS `VoteTypes` (
    `Id` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(30) NOT NULL
);
INSERT INTO `VoteTypes` (`Id`, `Name`) VALUES
    (1, 'AcceptedByOriginator'),
    (2, 'UpMod'),
    (3, 'DownMod'),
    (4, 'Offensive'),
    (5, 'Favorite'),
    (6, 'Close'),
    (7, 'Reopen'),
    (8, 'BountyStart'),
    (9, 'BountyClose'),
    (10, 'Deletion'),
    (11, 'Undeletion'),
    (12, 'Spam'),
    (13, 'ModeratorReview'),
    (16, 'ApproveEditSuggestion');
    
CREATE TABLE IF NOT EXISTS `PostTypes` (
    `Id` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(30) NOT NULL
);
INSERT INTO `PostTypes` (`Id`, `Name`) VALUES
    (1, 'Question'),
    (2, 'Answer'),
    (3, 'Wiki'),
    (4, 'TagWikiExcerpt'),
    (5, 'TagWiki'),
    (6, 'ModeratorNomination'),
    (7, 'WikiPlaceholder'),
    (8, 'PrivilegeWiki');
