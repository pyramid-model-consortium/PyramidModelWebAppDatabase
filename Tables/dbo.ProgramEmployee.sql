CREATE TABLE [dbo].[ProgramEmployee]
(
[ProgramEmployeePK] [int] NOT NULL IDENTITY(1, 1),
[AspireID] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Creator] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[Editor] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EditDate] [datetime] NULL,
[EmailAddress] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FirstName] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[HireDate] [datetime] NOT NULL,
[LastName] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TermDate] [datetime] NULL,
[TermReasonSpecify] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProgramFK] [int] NOT NULL,
[TermReasonCodeFK] [int] NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Benjamin Simmons
-- Create date: 08/07/2019
-- Description:	This trigger will update the related 'Changed' table
-- in order to provide a history of the last 5 actions on this table
-- record.
-- =============================================
CREATE TRIGGER [dbo].[TGR_ProgramEmployee_Changed] 
   ON  [dbo].[ProgramEmployee] 
   AFTER UPDATE, DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Get the change type
	DECLARE @ChangeType VARCHAR(100) = CASE WHEN EXISTS (SELECT * FROM Inserted) THEN 'Update' ELSE 'Delete' END

	--Insert the rows that have the original values (if you changed a 4 to a 5, this will insert the row with the 4)
    INSERT INTO dbo.ProgramEmployeeChanged
    SELECT GETDATE(), @ChangeType, d.*
	FROM Deleted d

	--To hold any existing change rows
	DECLARE @ExistingChangeRows TABLE (
		ProgramEmployeePK INT,
		MinChangeDatetime DATETIME
	)

	--Get the existing change rows if there are more than 5
	INSERT INTO @ExistingChangeRows
	(
	    ProgramEmployeePK,
	    MinChangeDatetime
	)
	SELECT ac.ProgramEmployeePK, CAST(MIN(ac.ChangeDatetime) AS DATETIME)
	FROM dbo.ProgramEmployeeChanged ac
	GROUP BY ac.ProgramEmployeePK
	HAVING COUNT(ac.ProgramEmployeePK) > 5

	--Delete the excess change rows to keep the number of change rows at 5
	DELETE ac
	FROM dbo.ProgramEmployeeChanged ac
	INNER JOIN @ExistingChangeRows ecr ON ac.ProgramEmployeePK = ecr.ProgramEmployeePK AND ac.ChangeDatetime = ecr.MinChangeDatetime
	WHERE ac.ProgramEmployeePK = ecr.ProgramEmployeePK AND ac.ChangeDatetime = ecr.MinChangeDatetime
	
END
GO
ALTER TABLE [dbo].[ProgramEmployee] ADD CONSTRAINT [PK_ProgramEmployee] PRIMARY KEY CLUSTERED  ([ProgramEmployeePK]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProgramEmployee] ADD CONSTRAINT [FK_ProgramEmployee_Program] FOREIGN KEY ([ProgramFK]) REFERENCES [dbo].[Program] ([ProgramPK])
GO
ALTER TABLE [dbo].[ProgramEmployee] ADD CONSTRAINT [FK_ProgramEmployee_TermReasonCode] FOREIGN KEY ([TermReasonCodeFK]) REFERENCES [dbo].[CodeTermReason] ([CodeTermReasonPK])
GO