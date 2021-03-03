/****** Object:  Table [dbo].[lookup]    Script Date: 3-3-2021 15:35:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lookup]') AND type in (N'U'))
DROP TABLE [dbo].[lookup]
GO

CREATE TABLE [dbo].[lookup](
	[lookupid] [bigint] IDENTITY(1,1) NOT NULL,
	[lookupvalue] [nvarchar](255) NULL,
	[sourcesystem] [nvarchar](50) NOT NULL,
	[targetsystem] [nvarchar](50) NOT NULL,
	[lookuptype] [nvarchar](255) NOT NULL,
	[lookupkey] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_lookup] PRIMARY KEY CLUSTERED 
(
	[lookupid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE INDEX IX_lookup ON [dbo].[lookup] ([sourcesystem],[targetsystem],[lookuptype],[lookupkey]);
GO