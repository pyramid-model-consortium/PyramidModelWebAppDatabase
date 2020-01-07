CREATE TABLE [dbo].[CoachingLogChanged]
(
[CoachingLogChangedPK] [int] NOT NULL IDENTITY(1, 1),
[ChangeDatetime] [datetime] NOT NULL,
[ChangeType] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CoachingLogPK] [int] NOT NULL,
[Creator] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[LogDate] [datetime] NOT NULL,
[DurationMinutes] [int] NOT NULL,
[Editor] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EditDate] [datetime] NULL,
[FUEmail] [bit] NOT NULL,
[FUInPerson] [bit] NOT NULL,
[FUNone] [bit] NOT NULL,
[FUPhone] [bit] NOT NULL,
[MEETDemonstration] [bit] NOT NULL,
[MEETEnvironment] [bit] NOT NULL,
[MEETGoalSetting] [bit] NOT NULL,
[MEETGraphic] [bit] NOT NULL,
[MEETMaterial] [bit] NOT NULL,
[MEETOther] [bit] NOT NULL,
[MEETOtherSpecify] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEETPerformance] [bit] NOT NULL,
[MEETProblemSolving] [bit] NOT NULL,
[MEETReflectiveConversation] [bit] NOT NULL,
[MEETRoleplay] [bit] NOT NULL,
[MEETVideo] [bit] NOT NULL,
[OBSConductTPITOS] [bit] NOT NULL,
[OBSConductTPOT] [bit] NOT NULL,
[OBSEnvironment] [bit] NOT NULL,
[OBSModeling] [bit] NOT NULL,
[OBSObserving] [bit] NOT NULL,
[OBSOther] [bit] NOT NULL,
[OBSOtherHelp] [bit] NOT NULL,
[OBSOtherSpecify] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OBSProblemSolving] [bit] NOT NULL,
[OBSReflectiveConversation] [bit] NOT NULL,
[OBSSideBySide] [bit] NOT NULL,
[OBSVerbalSupport] [bit] NOT NULL,
[CoachFK] [int] NOT NULL,
[TeacherFK] [int] NOT NULL,
[ProgramFK] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CoachingLogChanged] ADD CONSTRAINT [PK_CoachingLogChanged] PRIMARY KEY CLUSTERED  ([CoachingLogChangedPK]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_CoachingLogChanged_CoachingLogPK_ChangeDatetime] ON [dbo].[CoachingLogChanged] ([CoachingLogPK], [ChangeDatetime] DESC) ON [PRIMARY]
GO