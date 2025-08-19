# dremio-agentic-ai-workshop

- [Dremio docs](https://docs.dremio.com)
- [Dremio MCP server repository](https://github.com/dremio/dremio-mcp)

This repository is to accompany Dremio's Agentic AI Virtual Workshops. It contains SQL scripts that refine sample Dremio datasets to create a basic, two-layer data pipeline. 

- You will be creating and saving virtual datasets (Views) in Dremio.
- You will need to create an Enterprise Catalog called `workshop`, which will contain two folders, named `silver` and `gold`, into which the Views will be saved.
- This repo contains the following scripts:
    - `trips.sql` - an SQL SELECT statement to create a silver view from a sample dataset.
    - `complete_project.sql` - will create and save the rest of the views needed for the workshop.
    - `wiki_trips_enriched.md` - markdown documentation to be used as the Dremio Wiki for the gold-level dataset `trips_enriched`.
