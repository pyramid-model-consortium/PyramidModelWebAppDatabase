CREATE TABLE [dbo].[EmployeeClassroom]
(
[EmployeeClassroomPK] [int] NOT NULL IDENTITY(1, 1),
[AssignDate] [datetime] NOT NULL,
[Creator] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[Editor] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EditDate] [datetime] NULL,
[LeaveDate] [datetime] NULL,
[LeaveReasonSpecify] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ClassroomFK] [int] NOT NULL,
[JobTypeCodeFK] [int] NOT NULL CONSTRAINT [DF_EmployeeClassroom_JobTypeCodeFK] DEFAULT ((1)),
[LeaveReasonCodeFK] [int] NULL,
[EmployeeFK] [int] NOT NULL
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
CREATE TRIGGER [dbo].[TGR_EmployeeClassroom_Changed] 
   ON  [dbo].[EmployeeClassroom] 
   AFTER UPDATE, DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Get the change type
	DECLARE @ChangeType VARCHAR(100) = CASE WHEN EXISTS (SELECT * FROM Inserted) THEN 'Update' ELSE 'Delete' END

	--Insert the rows that have the original values (if you changed a 4 to a 5, this will insert the row with the 4)
    INSERT INTO dbo.EmployeeClassroomChanged
    SELECT GETDATE(), @ChangeType, d.*
	FROM Deleted d

	--To hold any existing change rows
	DECLARE @ExistingChangeRows TABLE (
		EmployeeClassroomPK INT,
		MinChangeDatetime DATETIME
	)

	--Get the existing change rows if there are more than 5
	INSERT INTO @ExistingChangeRows
	(
	    EmployeeClassroomPK,
	    MinChangeDatetime
	)
	SELECT ac.EmployeeClassroomPK, CAST(MIN(ac.ChangeDatetime) AS DATETIME)
	FROM dbo.EmployeeClassroomChanged ac
	GROUP BY ac.EmployeeClassroomPK
	HAVING COUNT(ac.EmployeeClassroomPK) > 5

	--Delete the excess change rows to keep the number of change rows at 5
	DELETE ac
	FROM dbo.EmployeeClassroomChanged ac
	INNER JOIN @ExistingChangeRows ecr ON ac.EmployeeClassroomPK = ecr.EmployeeClassroomPK AND ac.ChangeDatetime = ecr.MinChangeDatetime
	WHERE ac.EmployeeClassroomPK = ecr.EmployeeClassroomPK AND ac.ChangeDatetime = ecr.MinChangeDatetime
	
END
GO
ALTER TABLE [dbo].[EmployeeClassroom] ADD CONSTRAINT [PK_EmployeeClassroom] PRIMARY KEY CLUSTERED  ([EmployeeClassroomPK]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmployeeClassroom] ADD CONSTRAINT [FK_EmployeeClassroom_Classroom] FOREIGN KEY ([ClassroomFK]) REFERENCES [dbo].[Classroom] ([ClassroomPK])
GO
ALTER TABLE [dbo].[EmployeeClassroom] ADD CONSTRAINT [FK_EmployeeClassroom_CodeEmployeeLeaveReason] FOREIGN KEY ([LeaveReasonCodeFK]) REFERENCES [dbo].[CodeEmployeeLeaveReason] ([CodeEmployeeLeaveReasonPK])
GO
ALTER TABLE [dbo].[EmployeeClassroom] ADD CONSTRAINT [FK_EmployeeClassroom_CodeJobType] FOREIGN KEY ([JobTypeCodeFK]) REFERENCES [dbo].[CodeJobType] ([CodeJobTypePK])
GO
ALTER TABLE [dbo].[EmployeeClassroom] ADD CONSTRAINT [FK_EmployeeClassroom_ProgramEmployee] FOREIGN KEY ([EmployeeFK]) REFERENCES [dbo].[ProgramEmployee] ([ProgramEmployeePK])
GO