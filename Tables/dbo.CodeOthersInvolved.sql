CREATE TABLE [dbo].[CodeOthersInvolved]
(
[CodeOthersInvolvedPK] [int] NOT NULL,
[Abbreviation] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_CodeOthersInvolved_Abbreviation] DEFAULT ('Abbr'),
[Description] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EndDate] [datetime] NULL,
[OrderBy] [int] NOT NULL,
[StartDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CodeOthersInvolved] ADD CONSTRAINT [PK_CodeOthersInvolved] PRIMARY KEY CLUSTERED  ([CodeOthersInvolvedPK]) ON [PRIMARY]
GO
