CREATE TABLE [dbo].[CodeEthnicity]
(
[CodeEthnicityPK] [int] NOT NULL,
[Abbreviation] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_CodeEthnicity_Abbreviation] DEFAULT ('ABBR'),
[Description] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EndDate] [datetime] NULL,
[OrderBy] [int] NOT NULL,
[StartDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CodeEthnicity] ADD CONSTRAINT [PK_CodeEthnicity] PRIMARY KEY CLUSTERED  ([CodeEthnicityPK]) ON [PRIMARY]
GO
