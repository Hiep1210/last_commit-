/*CREATE PROC insertUser
@ID INT OUTPUT,
@pass VARCHAR(20),
@name NVARCHAR(50),
@user VARCHAR(60),
@isad BIT,
@gender NVARCHAR(10),
@dob DATE
AS 
BEGIN
	INSERT INTO dbo.UserS
	(
	    User_name,
	    Username,
	    id_Admin,
	    PASSWORD,
		Gender,
		dob
	)
	SELECT @name,@user,@isad,@pass,@gender, @dob
	SET @ID = (SELECT TOP 1 User_id FROM dbo.UserS ORDER BY User_id DESC)
END 
DECLARE @out INT;
EXEC dbo.insertUser @ID = @out OUTPUT, -- int
                    @pass = '123',       -- varchar(20)
                    @name = N'hiệp',      -- nvarchar(50)
                    @user = 'hung',       -- varchar(60)
                    @isad = 0,       -- bit
					@gender = 'Male',
					@dob = '12/10/2003'
					
SELECT @out
SELECT * FROM dbo.UserS
DELETE FROM dbo.UserS 
DROP PROC dbo.insertUser
CREATE PROC getUser
@ID int
AS
BEGIN
	SELECT * FROM dbo.UserS WHERE User_id = @ID
END
EXEC getUser @ID = 2
CREATE PROC delUser
@ID INT
AS
BEGIN
	DELETE FROM dbo.UserS WHERE User_id = @ID
END
EXEC delUser @ID =3

CREATE PROC updateUser
@ID INT,
@pass VARCHAR(20),
@name NVARCHAR(50),
@user VARCHAR(60),
@gender NVARCHAR(10),
@dob DATE
AS
BEGIN
	UPDATE dbo.UserS
	SET PASSWORD = @pass, User_name = @name, Username = @user, Gender = @gender, dob =@dob
	WHERE User_id =@ID
END
EXEC dbo.updateUser @ID = 2,            -- int
                    @pass = 'lam123',         -- varchar(20)
                    @name = N'lam phung',        -- nvarchar(50)
                    @user = 'lam',         -- varchar(60)
                    @gender = N'Male',      -- nvarchar(10)
                    @dob = '16/3/2003' -- date
CREATE PROC checkDuplicate
@user NVARCHAR(60),
@out int output
AS
BEGIN
Set @out = (SELECT Count(*) FROM dbo.UserS WHERE Username =@user)
END
CREATE PROC FindUser
@user NVARCHAR(60),
@pass VARCHAR(50)
AS
BEGIN
SELECT * FROM dbo.UserS WHERE Username = @user
END
EXEC FindUser @user = 'hung', @pass = '123'
SELECT * INTO Admintab FROM dbo.UserS WHERE id_Admin = 1
SELECT * FROM dbo.Admintab a, dbo.News n
WHERE a.User_id = n.User_id AND a.User_id = 1
*/
------------category-------
CREATE PROC insertCate
@name NVARCHAR(50),
@des NVARCHAR(100)
AS
BEGIN
	INSERT INTO dbo.Category
	(
	    Cat_name,
	    Cat_description
	)
	SELECT @name, @des
END
SELECT * FROM dbo.Category
SELECT * FROM userS
SELECT * FROM dbo.News
CREATE PROC delCate
@id INT
AS
BEGIN
	DELETE FROM dbo.Category WHERE Cat_id = @id
END
USE NewWebsite1
SELECT * FROM dbo.Comment
INSERT INTO dbo.Comment
(
    User_id,
    News_id,
    Comment_content
)
VALUES
(   1,  -- User_id - int
    3,  -- News_id - int
    N'comment1' -- Comment_content - nvarchar(max)
    ),(2,3,N'comment2'),(3,3,N'comment3')
SELECT * FROM dbo.[Save]

