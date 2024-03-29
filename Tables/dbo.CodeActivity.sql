CREATE TABLE [dbo].[CodeActivity]
(
[CodeActivityPK] [int] NOT NULL,
[Abbreviation] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_CodeActivity_Abbreviation] DEFAULT ('Abbr'),
[Description] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EndDate] [datetime] NULL,
[OrderBy] [int] NOT NULL,
[StartDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CodeActivity] ADD CONSTRAINT [PK_CodeActivity] PRIMARY KEY CLUSTERED  ([CodeActivityPK]) ON [PRIMARY]
GO
