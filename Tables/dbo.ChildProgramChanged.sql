CREATE TABLE [dbo].[ChildProgramChanged]
(
[ChildProgramChangedPK] [int] NOT NULL IDENTITY(1, 1),
[ChangeDatetime] [datetime] NOT NULL,
[ChangeType] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Deleter] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ChildProgramPK] [int] NOT NULL,
[Creator] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[Editor] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EditDate] [datetime] NULL,
[DischargeDate] [datetime] NULL,
[DischargeReasonSpecify] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EnrollmentDate] [datetime] NOT NULL,
[HasIEP] [bit] NOT NULL,
[HasParentPermission] [bit] NOT NULL CONSTRAINT [DF_ChildProgramChanged_HasParentPermission] DEFAULT ((1)),
[IsDLL] [bit] NOT NULL,
[ParentPermissionDocumentFileName] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ParentPermissionDocumentFilePath] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProgramSpecificID] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ChildFK] [int] NOT NULL,
[DischargeCodeFK] [int] NULL,
[ProgramFK] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChildProgramChanged] ADD CONSTRAINT [PK_ChildProgramChanged] PRIMARY KEY CLUSTERED ([ChildProgramChangedPK]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ChildProgramChanged_ChildProgramPK_ChangeDatetime] ON [dbo].[ChildProgramChanged] ([ChildProgramPK], [ChangeDatetime] DESC) ON [PRIMARY]
GO
