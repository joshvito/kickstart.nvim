-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown' },
    opts = {},
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' },
    ft = { 'markdown' },
    -- Do what app/install.cmd does, but in PowerShell directly. mkdp#util#install
    -- goes through vim.opt.shell (Git Bash here), which can't run install.cmd.
    build = function(plugin)
      local version = vim.json.decode(table.concat(vim.fn.readfile(plugin.dir .. '/package.json'), '\n')).version
      local script = table.concat({
        "$ErrorActionPreference = 'Stop'",
        "$ProgressPreference = 'SilentlyContinue'",
        '$zip = "markdown-preview-win.zip"',
        'Invoke-WebRequest "https://github.com/iamcco/markdown-preview.nvim/releases/download/v' .. version .. '/$zip" -OutFile $zip',
        'New-Item bin -ItemType Directory -Force | Out-Null',
        'Expand-Archive $zip -DestinationPath bin -Force',
        'Remove-Item $zip -Force',
      }, '; ')
      local result = vim.system(
        { 'powershell.exe', '-NoProfile', '-ExecutionPolicy', 'Bypass', '-Command', script },
        { cwd = plugin.dir .. '/app' }
      ):wait()
      if result.code ~= 0 then
        error('markdown-preview install failed: ' .. (result.stderr or '') .. (result.stdout or ''))
      end
    end,
  },
}
