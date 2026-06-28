/* ============================================================
   KAUMUDI VIM - Interactive Logic Layer
   ============================================================ */

document.addEventListener("DOMContentLoaded", () => {
  initThemeSystem();
  initThemeShowcase();
  initKeybindsHub();
  initCopyBlocks();
});

/* ── Light / Dark Mode Toggle ─────────────────────────────── */
function initThemeSystem() {
  const toggleBtn = document.getElementById("theme-toggle-btn");
  const htmlRoot = document.documentElement;

  // Retrieve previous settings or default to user preference
  const savedTheme = localStorage.getItem("kaumudi-site-theme");
  const prefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
  
  const initialTheme = savedTheme || (prefersDark ? "dark" : "light");
  htmlRoot.setAttribute("data-theme", initialTheme);

  toggleBtn.addEventListener("click", () => {
    const currentTheme = htmlRoot.getAttribute("data-theme");
    const newTheme = currentTheme === "dark" ? "light" : "dark";
    
    htmlRoot.setAttribute("data-theme", newTheme);
    localStorage.setItem("kaumudi-site-theme", newTheme);
  });
}

/* ── Live Mockup Theme Swapping ────────────────────────────── */
function initThemeShowcase() {
  const pills = document.querySelectorAll(".theme-pill");
  const mockup = document.getElementById("preview-editor-window");
  const heroImg = document.getElementById("hero-showcase-img");

  pills.forEach(pill => {
    pill.addEventListener("click", () => {
      // Toggle active states
      pills.forEach(p => p.classList.remove("active"));
      pill.classList.add("active");

      // Apply mockup styles
      const bg = pill.getAttribute("data-bg");
      const fg = pill.getAttribute("data-fg");
      const accent = pill.getAttribute("data-accent");
      const themeName = pill.getAttribute("data-theme-name");

      mockup.style.setProperty("--mockup-bg", bg);
      mockup.style.setProperty("--mockup-fg", fg);
      mockup.style.setProperty("--mockup-accent", accent);

      // Swap screenshot mockup image for visual interest
      if (themeName === "rose-pine") {
        heroImg.src = "images/demo1.png";
      } else {
        heroImg.src = "images/demo0.png";
      }
    });
  });
}

/* ── Keybindings Dynamic Filter & Search ──────────────────── */
const KEYBINDINGS_DATA = [
  // Core
  { key: "<leader>e", action: "Toggle file explorer sidebar", cat: "core" },
  { key: "<leader>ff", action: "Find files (Telescope)", cat: "core" },
  { key: "<leader>fw", action: "Live grep (Search text in project)", cat: "core" },
  { key: "<leader>fb", action: "List active open buffers", cat: "core" },
  { key: "<leader>fr", action: "Open recent files list", cat: "core" },
  { key: "<leader>tt", action: "Telescope Theme Picker", cat: "core" },
  { key: "<C-\\>", action: "Toggle floating terminal", cat: "core" },
  { key: "<C-s>", action: "Save current file", cat: "core" },
  { key: "<leader>u", action: "Toggle visual Undo Tree", cat: "core" },
  { key: "<leader>?", action: "Open WhichKey keymap guide", cat: "core" },
  
  // LSP
  { key: "gd", action: "Go to symbol definition", cat: "lsp" },
  { key: "gD", action: "Go to symbol declaration", cat: "lsp" },
  { key: "gi", action: "Go to symbol implementation", cat: "lsp" },
  { key: "gr", action: "Find symbol references", cat: "lsp" },
  { key: "gt", action: "Go to type definition", cat: "lsp" },
  { key: "K", action: "Show hover documentation", cat: "lsp" },
  { key: "<C-k>", action: "Show signature help tooltip", cat: "lsp" },
  { key: "<leader>ca", action: "Execute LSP code action", cat: "lsp" },
  { key: "<leader>rn", action: "Rename symbol globally", cat: "lsp" },
  { key: "<leader>fm", action: "Format file via Conform.nvim", cat: "lsp" },
  { key: "<leader>ih", action: "Toggle inlay hints inline", cat: "lsp" },

  // Navigation
  { key: "<leader>a", action: "Harpoon: add file to menu", cat: "nav" },
  { key: "<C-e>", action: "Harpoon: toggle quick switch menu", cat: "nav" },
  { key: "<C-1> to <C-7>", action: "Harpoon: jump to file index 1–7", cat: "nav" },
  { key: "<leader>h1" + "–" + "h7", action: "Harpoon: jump to index 1–7 (leader)", cat: "nav" },
  { key: "<A-,>", action: "Switch to previous buffer (tab)", cat: "nav" },
  { key: "<A-.>", action: "Switch to next buffer (tab)", cat: "nav" },
  { key: "<A-c>", action: "Close current buffer", cat: "nav" },
  { key: "<C-p>", action: "BufferPick (select tab by visual key)", cat: "nav" },

  // Splits
  { key: "<leader>sv", action: "Split window vertically", cat: "splits" },
  { key: "<leader>sh", action: "Split window horizontally", cat: "splits" },
  { key: "<leader>sx", action: "Close current window split", cat: "splits" },
  { key: "<C-h>", action: "Navigate window split right", cat: "splits" },
  { key: "<C-l>", action: "Navigate window split left", cat: "splits" },
  { key: "<C-t>", action: "Navigate window split up", cat: "splits" },
  { key: "<C-d>", action: "Navigate window split down", cat: "splits" },

  // Sessions
  { key: "<leader>ws", action: "Save current session in directory", cat: "session" },
  { key: "<leader>wr", action: "Restore directory workspace session", cat: "session" },
  { key: "<leader>wd", action: "Delete workspace session", cat: "session" }
];

function initKeybindsHub() {
  const searchInput = document.getElementById("keybinds-search");
  const catButtons = document.querySelectorAll(".cat-btn");
  const listContainer = document.getElementById("keybindings-list");

  let activeCategory = "all";
  let searchQuery = "";

  function renderKeybindings() {
    listContainer.innerHTML = "";
    
    const filtered = KEYBINDINGS_DATA.filter(item => {
      const matchesCategory = activeCategory === "all" || item.cat === activeCategory;
      const matchesSearch = item.key.toLowerCase().includes(searchQuery.toLowerCase()) || 
                            item.action.toLowerCase().includes(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    });

    if (filtered.length === 0) {
      listContainer.innerHTML = `<tr><td colspan="3" class="text-center" style="opacity: 0.5; padding: 32px 0; text-align: center;">No matches found for your query.</td></tr>`;
      return;
    }

    filtered.forEach(item => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td><kbd>${item.key}</kbd></td>
        <td>${item.action}</td>
        <td><span class="category-tag">${item.cat}</span></td>
      `;
      listContainer.appendChild(row);
    });
  }

  // Bind category button clicks
  catButtons.forEach(btn => {
    btn.addEventListener("click", () => {
      catButtons.forEach(b => b.classList.remove("active"));
      btn.classList.add("active");
      activeCategory = btn.getAttribute("data-category");
      renderKeybindings();
    });
  });

  // Bind search text inputs
  searchInput.addEventListener("input", (e) => {
    searchQuery = e.target.value;
    renderKeybindings();
  });

  // Render initially
  renderKeybindings();
}

/* ── Copy Codeblock Utilities ─────────────────────────────── */
function initCopyBlocks() {
  const copyButtons = document.querySelectorAll(".copy-btn");

  copyButtons.forEach(btn => {
    btn.addEventListener("click", async () => {
      const targetId = btn.getAttribute("data-target");
      const targetCode = document.getElementById(targetId);
      
      if (!targetCode) return;

      try {
        await navigator.clipboard.writeText(targetCode.innerText);
        
        // Visual confirmation
        const originalText = btn.innerText;
        btn.innerText = "Copied!";
        btn.style.backgroundColor = "var(--accent-color)";
        btn.style.color = "#000";
        btn.style.borderColor = "var(--accent-color)";

        setTimeout(() => {
          btn.innerText = originalText;
          btn.style.backgroundColor = "";
          btn.style.color = "";
          btn.style.borderColor = "";
        }, 1800);
      } catch (err) {
        console.error("Failed to copy command block: ", err);
      }
    });
  });
}
