SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Ben Simmons
-- Create date: 10/10/2019
-- Description:	This stored procedure returns the necessary information for the
-- Login History report
-- =============================================
CREATE PROC [dbo].[rspLoginHistory]
	@StartDate DATETIME = NULL,
	@EndDate DATETIME = NULL,
	@ProgramFKs VARCHAR(8000) = NULL,
	@HubFKs VARCHAR(8000) = NULL,
	@CohortFKs VARCHAR(8000) = NULL,
	@StateFKs VARCHAR(8000) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	--Get the login history
	SELECT lh.LoginHistoryPK, 
		   lh.LoginTime, 
		   lh.LogoutTime, 
		   lh.LogoutType, 
		   lh.[Role], 
		   lh.Username, 
		   lh.ProgramFK, 
           p.ProgramName
	FROM dbo.LoginHistory lh
	INNER JOIN dbo.Program p 
		ON p.ProgramPK = lh.ProgramFK
	LEFT JOIN dbo.SplitStringToInt(@ProgramFKs, ',') programList 
		ON programList.ListItem = lh.ProgramFK
	LEFT JOIN dbo.SplitStringToInt(@HubFKs, ',') hubList 
		ON hubList.ListItem = p.HubFK
	LEFT JOIN dbo.SplitStringToInt(@CohortFKs, ',') cohortList 
		ON cohortList.ListItem = p.CohortFK
	LEFT JOIN dbo.SplitStringToInt(@StateFKs, ',') stateList 
		ON stateList.ListItem = p.StateFK
	WHERE (programList.ListItem IS NOT NULL OR 
			hubList.ListItem IS NOT NULL OR 
			cohortList.ListItem IS NOT NULL OR
			stateList.ListItem IS NOT NULL) AND  --At least one of the options must be utilized 
		lh.LoginTime >= @StartDate AND
		lh.LoginTime <= @EndDate
	ORDER BY lh.LoginTime DESC;

END
GO
