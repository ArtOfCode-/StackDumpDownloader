-- Schema creation SQL designed for MySQL systems.

CREATE TABLE `Badges` (
	`Id` INT(11) NOT NULL AUTO_INCREMENT,
	`SiteSpecificId` INT(11) NOT NULL,
	`UserId` INT(11) NOT NULL,
	`Name` VARCHAR(50) NOT NULL COLLATE 'utf8_unicode_ci',
	`Date` DATETIME NOT NULL,
	`Class` TINYINT(1) NOT NULL,
	`TagBased` TINYINT(1) NOT NULL,
	`Site` VARCHAR(50) NOT NULL COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`Id`),
	INDEX `SiteSpecificId` (`SiteSpecificId`),
	INDEX `Name` (`Name`),
	INDEX `Site` (`Site`)
);

CREATE TABLE `Comments` (
	`Id` INT(11) NOT NULL AUTO_INCREMENT,
	`SiteSpecificId` INT(11) NOT NULL,
	`PostId` INT(11) NOT NULL,
	`Score` INT(11) NOT NULL,
	`Text` VARCHAR(500) NOT NULL COLLATE 'utf8_unicode_ci',
	`CreationDate` DATETIME NOT NULL,
	`UserId` INT(11) NOT NULL,
	`UserDisplayName` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`Site` VARCHAR(50) NOT NULL COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`Id`),
	INDEX `SiteSpecificId` (`SiteSpecificId`),
	INDEX `UserDisplayName` (`UserDisplayName`),
	INDEX `Site` (`Site`),
	INDEX `Score` (`Score`)
);

CREATE TABLE `PostHistory` (
	`Id` INT(11) NOT NULL AUTO_INCREMENT,
	`SiteSpecificId` INT(11) NOT NULL,
	`PostHistoryTypeId` INT(11) NOT NULL,
	`PostId` INT(11) NOT NULL,
	`RevisionGUID` VARCHAR(40) NOT NULL COLLATE 'utf8_unicode_ci',
	`CreationDate` DATETIME NOT NULL,
	`UserDisplayName` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`Comment` VARCHAR(500) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`UserId` INT(11) NULL DEFAULT NULL,
	`Text` MEDIUMTEXT NULL COLLATE 'utf8_unicode_ci',
	`Site` VARCHAR(50) NOT NULL COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`Id`),
	INDEX `SiteSpecificId` (`SiteSpecificId`),
	INDEX `Site` (`Site`),
	INDEX `UserDisplayName` (`UserDisplayName`),
	INDEX `RevisionGUID` (`RevisionGUID`),
	INDEX `PostHistoryTypeId` (`PostHistoryTypeId`),
	INDEX `PostId` (`PostId`)
);

CREATE TABLE `PostLinks` (
	`Id` INT(11) NOT NULL AUTO_INCREMENT,
	`SiteSpecificId` INT(11) NOT NULL,
	`CreationDate` DATETIME NOT NULL,
	`PostId` INT(11) NOT NULL,
	`RelatedPostId` INT(11) NOT NULL,
	`LinkTypeId` INT(11) NOT NULL,
	`Site` VARCHAR(50) NOT NULL COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`Id`),
	INDEX `SiteSpecificId` (`SiteSpecificId`),
	INDEX `Site` (`Site`),
	INDEX `PostId` (`PostId`),
	INDEX `RelatedPostId` (`RelatedPostId`)
);

CREATE TABLE `Posts` (
	`Id` INT(11) NOT NULL AUTO_INCREMENT,
	`SiteSpecificId` INT(11) NOT NULL,
	`PostTypeId` INT(11) NOT NULL,
	`ParentId` INT(11) NULL DEFAULT NULL,
	`AcceptedAnswerId` INT(11) NULL DEFAULT NULL,
	`CreationDate` DATETIME NOT NULL,
	`Score` INT(11) NOT NULL,
	`ViewCount` INT(11) NULL DEFAULT NULL,
	`Body` MEDIUMTEXT NOT NULL COLLATE 'utf8_unicode_ci',
	`OwnerUserId` INT(11) NOT NULL,
	`OwnerDisplayName` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`LastEditorUserId` INT(11) NULL DEFAULT NULL,
	`LastEditorDisplayName` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`LastEditDate` DATETIME NULL DEFAULT NULL,
	`LastActivityDate` DATETIME NULL DEFAULT NULL,
	`Title` VARCHAR(120) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`Tags` VARCHAR(140) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`AnswerCount` INT(11) NULL DEFAULT NULL,
	`CommentCount` INT(11) NULL DEFAULT NULL,
	`FavoriteCount` INT(11) NULL DEFAULT NULL,
	`ClosedDate` DATETIME NULL DEFAULT NULL,
	`CommunityOwnedDate` DATETIME NULL DEFAULT NULL,
	`Site` VARCHAR(50) NOT NULL COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`Id`),
	INDEX `SiteSpecificId` (`SiteSpecificId`),
	INDEX `PostTypeId` (`PostTypeId`),
	INDEX `Score` (`Score`),
	INDEX `OwnerUserId` (`OwnerUserId`),
	INDEX `OwnerDisplayName` (`OwnerDisplayName`),
	INDEX `Title` (`Title`),
	INDEX `Tags` (`Tags`),
	INDEX `ClosedDate` (`ClosedDate`),
	INDEX `Site` (`Site`)
);

CREATE TABLE `Tags` (
	`Id` INT(11) NOT NULL AUTO_INCREMENT,
	`SiteSpecificId` INT(11) NOT NULL,
	`TagName` VARCHAR(25) NOT NULL COLLATE 'utf8_unicode_ci',
	`Count` INT(11) NOT NULL,
	`ExcerptPostId` INT(11) NOT NULL,
	`WikiPostId` INT(11) NOT NULL,
	`Site` VARCHAR(50) NOT NULL COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`Id`),
	INDEX `SiteSpecificId` (`SiteSpecificId`),
	INDEX `Site` (`Site`),
	INDEX `Count` (`Count`),
	INDEX `TagName` (`TagName`)
);

CREATE TABLE `Users` (
	`Id` INT(11) NOT NULL AUTO_INCREMENT,
	`SiteSpecificId` INT(11) NOT NULL,
	`Reputation` INT(11) NOT NULL,
	`CreationDate` DATETIME NOT NULL,
	`DisplayName` VARCHAR(100) NOT NULL COLLATE 'utf8_unicode_ci',
	`LastAccessDate` DATETIME NULL DEFAULT NULL,
	`Location` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`AboutMe` MEDIUMTEXT NULL COLLATE 'utf8_unicode_ci',
	`Views` INT(11) NOT NULL,
	`UpVotes` INT(11) NOT NULL,
	`DownVotes` INT(11) NOT NULL,
	`Age` INT(3) NULL DEFAULT NULL,
	`AccountId` INT(11) NOT NULL,
	`ProfileImageUrl` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`WebsiteUrl` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`Site` VARCHAR(50) NOT NULL COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`Id`),
	INDEX `SiteSpecificId` (`SiteSpecificId`),
	INDEX `Reputation` (`Reputation`),
	INDEX `DisplayName` (`DisplayName`),
	INDEX `UpVotes` (`UpVotes`),
	INDEX `DownVotes` (`DownVotes`),
	INDEX `AccountId` (`AccountId`),
	INDEX `Site` (`Site`)
);

CREATE TABLE `Votes` (
	`Id` INT(11) NOT NULL AUTO_INCREMENT,
	`SiteSpecificId` INT(11) NOT NULL,
	`PostId` INT(11) NOT NULL,
	`VoteTypeId` INT(11) NOT NULL,
	`UserId` INT(11) NULL DEFAULT NULL,
	`CreationDate` DATETIME NOT NULL,
	`BountyAmount` INT(11) NULL DEFAULT NULL,
	`Site` VARCHAR(50) NOT NULL COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`Id`),
	INDEX `SiteSpecificId` (`SiteSpecificId`),
	INDEX `PostId` (`PostId`),
	INDEX `VoteTypeId` (`VoteTypeId`),
	INDEX `Site` (`Site`)
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
