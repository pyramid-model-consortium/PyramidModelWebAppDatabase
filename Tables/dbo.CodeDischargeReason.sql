CREATE TABLE [dbo].[CodeDischargeReason]
(
[CodeDischargeReasonPK] [int] NOT NULL,
[Abbreviation] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_CodeDischargeReason_Abbreviation] DEFAULT ('ABBR'),
[Description] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EndDate] [datetime] NULL,
[OrderBy] [int] NOT NULL,
[StartDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CodeDischargeReason] ADD CONSTRAINT [PK_CodeDischargeReason] PRIMARY KEY CLUSTERED  ([CodeDischargeReasonPK]) ON [PRIMARY]
GO
