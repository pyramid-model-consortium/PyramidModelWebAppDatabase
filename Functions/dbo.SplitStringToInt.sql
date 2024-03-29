SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE FUNCTION [dbo].[SplitStringToInt]
(
  @List  VARCHAR(MAX),
  @Delim VARCHAR(10)
)
RETURNS 
@ParsedList TABLE
(
  ListItem INT
)
AS
/*----------------------------------------------------------------------------------------------
' Function       : SplitString
'
' Description    : Split a string using the passed delimeter - returns a Table variable
'
' Change History :
'
' WHEN        WHO  WHAT
'----------------------------------------------------------------------------------------------
'--------------------------------------------------------------------------------------------*/
BEGIN
  
  DECLARE @ListItem  VARCHAR(255)
  DECLARE @Pos       INT

  -- Ensure we have a trailing delimiter
  IF RIGHT(@List,LEN(@Delim)) <> @Delim
    SET @List = LTRIM(RTRIM(@List))+ @Delim

  SET @Pos = CHARINDEX(@Delim, @List, 1)

  IF REPLACE(@List, @Delim, '') <> ''
  BEGIN

    -- Break up the string
    WHILE @Pos > 0
    BEGIN
      
      SET @ListItem = LTRIM(RTRIM(LEFT(@List, @Pos - 1)))
      
      IF @ListItem <> ''
        INSERT INTO @ParsedList (ListItem) VALUES (@ListItem)

      SET @List = RIGHT(@List, LEN(@List) - @Pos - LEN(@Delim) + 1)
      SET @Pos = CHARINDEX(@Delim, @List, 1)

    END

  END	
  RETURN

END
GO
