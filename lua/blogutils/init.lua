local M = {}

M.formatTitle = function(input)
    return M.formatText(input, "apTitle")
end

M.formatSlug = function(input)
    return M.formatText(input, "slug")
end

M.formatText = function(input, format)
    local Job = require("plenary.job")

    local output = input
    Job:new({
        command = "textcase",
        args = {
            "--format", format,
            "--input", input,
        },
        cwd = "/usr/bin",
        on_stdout = function(_, data, _)
            output = data
        end,
    }):sync()

    return output
end

M.generateFrontMatter = function()
    -- get first row of file as input
    local input = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1] or "Example Title"

    -- build frontmatter data
    local date = vim.fn.strftime("%Y-%m-%dT%H:%M:%S")
    local slug = vim.fn.strftime("%Y-%m-%d-%H-%M")
    local title = ""
    if #input > 0 then
        slug = M.formatSlug(input)
        title = M.formatTitle(input)
    end

    -- insert data into buffer
    vim.api.nvim_buf_set_lines(0, 0, 1, true, {
        '---',
        'title: ' .. title,
        'slug: ' .. slug,
        'date: ' .. date,
        'categories: []',
        '---'
    })
end

return M


