CREATE TABLE [dbo].[lookup](
	[lookupid] [bigint] IDENTITY(1,1) NOT NULL,
	[lookupvalue] [nvarchar](255) NULL,
	[sourcesystem] [nvarchar](50) NOT NULL,
	[targetsystem] [nvarchar](50) NOT NULL,
	[lookuptype] [nvarchar](255) NOT NULL,
	[lookupkey] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_lookup] PRIMARY KEY CLUSTERED ([lookupid])
)
GO

CREATE INDEX IX_lookup ON [dbo].[lookup] ([sourcesystem],[targetsystem],[lookuptype],[lookupkey]);
GO