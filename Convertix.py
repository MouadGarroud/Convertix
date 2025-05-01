import sys
import os
import threading
import tkinter as tk
from tkinter import filedialog, messagebox, ttk
from docx2pdf import convert as docx2pdf_convert
from pdf2docx import Converter

# 🔧 Fix PyInstaller + docx2pdf crash on frozen stdout/stderr
if getattr(sys, 'frozen', False):
    if sys.stdout is None:
        sys.stdout = open(os.devnull, 'w')
    if sys.stderr is None:
        sys.stderr = open(os.devnull, 'w')

class ConvertixApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Convertix - Word ↔ PDF Converter")
        self.root.geometry("500x330")
        self.root.configure(bg="#f5f5f5")
        self.root.resizable(False, False)
        try:
            self.root.iconbitmap("Convertix.ico")  # Your icon here
        except:
            pass  # Fallback if icon fails
        self.setup_ui()

    def setup_ui(self):
        # App Title
        tk.Label(self.root, text="📄 Convertix", font=("Segoe UI", 20, "bold"), bg="#f5f5f5", fg="#333").pack(pady=20)

        # Buttons
        frame = tk.Frame(self.root, bg="#f5f5f5")
        frame.pack(pady=10)

        self.docx_to_pdf_btn = ttk.Button(frame, text="Convert DOCX to PDF", command=self.threaded_docx_to_pdf, width=30)
        self.docx_to_pdf_btn.grid(row=0, column=0, padx=10, pady=10)

        self.pdf_to_docx_btn = ttk.Button(frame, text="Convert PDF to DOCX", command=self.threaded_pdf_to_docx, width=30)
        self.pdf_to_docx_btn.grid(row=1, column=0, padx=10, pady=10)

        # Progress Bar
        self.progress = ttk.Progressbar(self.root, orient="horizontal", length=300, mode="indeterminate")
        self.progress.pack(pady=10)

        # Status Text
        self.status = tk.Label(self.root, text="", font=("Segoe UI", 10), bg="#f5f5f5", fg="gray")
        self.status.pack(side=tk.BOTTOM, pady=10)

        self.set_style()

    def set_style(self):
        style = ttk.Style()
        style.configure("TButton", font=("Segoe UI", 11), padding=6)
        style.map("TButton", foreground=[('pressed', 'black'), ('active', '#005A9C')])

    def threaded_docx_to_pdf(self):
        threading.Thread(target=self.convert_docx_to_pdf).start()

    def threaded_pdf_to_docx(self):
        threading.Thread(target=self.convert_pdf_to_docx).start()

    def convert_docx_to_pdf(self):
        self.update_status("Selecting DOCX file...")
        self.toggle_ui(False)

        filepath = filedialog.askopenfilename(filetypes=[("Word Documents", "*.docx")])
        if not filepath:
            self.update_status("Conversion cancelled.")
            self.toggle_ui(True)
            return

        try:
            self.update_status("Converting DOCX to PDF...")
            self.progress.start()
            folder = os.path.dirname(filepath)
            docx2pdf_convert(filepath, folder)
            output_path = os.path.join(folder, os.path.splitext(os.path.basename(filepath))[0] + ".pdf")
            self.update_status(f"✅ Saved to: {output_path}")
            messagebox.showinfo("Convertix", f"DOCX ➡ PDF saved to:\n{output_path}")
        except Exception as e:
            self.update_status("❌ Conversion failed.")
            messagebox.showerror("Convertix - Error", f"Failed to convert DOCX to PDF:\n{e}")

        self.progress.stop()
        self.toggle_ui(True)

    def convert_pdf_to_docx(self):
        self.update_status("Selecting PDF file...")
        self.toggle_ui(False)

        filepath = filedialog.askopenfilename(filetypes=[("PDF Files", "*.pdf")])
        if not filepath:
            self.update_status("Conversion cancelled.")
            self.toggle_ui(True)
            return

        try:
            self.update_status("Converting PDF to DOCX...")
            self.progress.start()
            folder = os.path.dirname(filepath)
            output_file = os.path.join(folder, os.path.splitext(os.path.basename(filepath))[0] + ".docx")
            cv = Converter(filepath)
            cv.convert(output_file, start=0, end=None)
            cv.close()
            self.update_status(f"✅ Saved to: {output_file}")
            messagebox.showinfo("Convertix", f"PDF ➡ DOCX saved to:\n{output_file}")
        except Exception as e:
            self.update_status("❌ Conversion failed.")
            messagebox.showerror("Convertix - Error", f"Failed to convert PDF to DOCX:\n{e}")

        self.progress.stop()
        self.toggle_ui(True)

    def update_status(self, message):
        self.status.config(text=message)

    def toggle_ui(self, state):
        new_state = tk.NORMAL if state else tk.DISABLED
        self.docx_to_pdf_btn.config(state=new_state)
        self.pdf_to_docx_btn.config(state=new_state)
        if state:
            self.progress.stop()

if __name__ == "__main__":
    root = tk.Tk()
    app = ConvertixApp(root)
    root.mainloop()
