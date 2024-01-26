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
    local input = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]

    -- build frontmatter data
    local fm = {}
    fm[0] = "---"
    fm[1] = "date: " .. vim.fn.strftime("%Y-%m-%dT%H:%M:%S")
    fm[2] = "categories: []"
    if #input == 0 then
        fm[3] = "slug: " .. vim.fn.strftime("%Y-%m-%d-%H%M")
        fm[4] = "---"
    else
        fm[3] = "slug: " .. M.formatSlug(input)
        fm[4] = "title: " .. M.formatTitle(input)
        fm[5] = "---"
    end

    vim.inspect(fm)

    -- insert data into buffer
    vim.api.nvim_buf_set_lines(0, 0, 1, true, fm)
end

return M
