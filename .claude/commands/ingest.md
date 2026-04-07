Process raw content input (URL, video link, image, business card, description) into the vision-vault.

Follow the Content Ingestion Workflow from CLAUDE.md exactly:

1. **Create a board task** in `.polyphony/board/todo/` using the appropriate ID prefix (BARK-, TOOL-, REF-, CASE-, VIS-, FAIL-). Commit it as `in-progress`.

2. **Evaluate the input** — determine relevance to project clusters, identify content type, and route to the correct vault section.

3. **Apply the disambiguation protocol** — if type or scope is unclear, ask exactly one focused question before proceeding. Never ask multiple questions at once.

4. **Write the vault note** — `status: seed`, include `## Source` with the origin URL/description, add agent identifier to `contributors:`.

5. **Complete the board task** — move to `review/`, append completion report, commit.

The input to process is: $ARGUMENTS
