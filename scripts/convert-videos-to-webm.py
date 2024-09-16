#import gi
#gi.require_version('Gtk', '3.0')
#from gi.repository import Gtk as gtk
import os
import time
import sys
import subprocess
import tkinter as tk
from tkinter import filedialog
from tkinter.filedialog import askopenfilenames
gtk_enabled = False

def main():
	print("Select videos folder to convert...")
	paths = get_files()
	paths.reverse()
	
	save_path = get_save_path()
	print(save_path)

	# Delete old log
	logPath = os.path.join(save_path, 'log.txt')
	if os.path.isfile(logPath):
		os.remove(logPath)
		
	# Make new log
	file = open(logPath, 'w')
	file.write("")
	file.close()
		
	# Show new log
	logProc = subprocess.Popen("foot watch -n 1 \"cat '" + logPath + "' | tail -n 5\"", shell=True)
	
	bar = ProgressBar(print_to_file = logPath)
	
	if len(paths) > 0:
		for i in range(len(paths)):
			try:
				path = paths[i]
				newPath = os.path.join(save_path, os.path.basename(path).replace(".mp4", ".webm").replace(".mkv", ".webm"))
				bar.draw(i/len(paths), path)
				
				# Skip file if the output already ecists
				if os.path.isfile(newPath):
					bar.output("\nSkipped file " + newPath + " because it already existed\n")
					continue
				
				# Output with ffmpeg
				command = 'ffmpeg -i \'' + path + '\' \'' + newPath + "'"
				print(command)
				os.system(command)
				
			except Exception as e:
				print("File", path, "failed to convert...")
				print(e)
	print()
	
	time.sleep(3)
	
	logProc.terminate()
	os.system("notify-send \"Video Conversion Finished\"")
		

class ProgressBar:
	def __init__(self, length = 50, percent = True, bar_char = "-", bar_ends = "|", bar_space = " ", print_to_file = None):
		self.length = length
		self.percent = percent
		self.bar_char = bar_char
		self.bar_ends = bar_ends
		self.bar_space = bar_space
		self.print_to_file = print_to_file

	def draw(self, progress, extra):
		bar = self.bar_ends
		for i in range(int(progress * self.length)):
			bar += self.bar_char
		for i in range(self.length - int(progress * self.length)):
			bar += self.bar_space
		bar += self.bar_ends

		if self.percent:
			percent = int(progress * 100)
		bar += " " + str(percent) + "%" + " :: " + extra

		if self.print_to_file == None:
			print("\r" + bar, end = "")
		else:
			file = open(self.print_to_file, 'a')
			file.write(bar + "\n")
			file.close()
			
	def output(self, output):
		if self.print_to_file == None:
			print(output)
		else:
			file = open(self.print_to_file, 'a')
			file.write(output)
			file.close()

def get_files():
	if gtk_enabled:
		dialog = gtk.FileChooserDialog(
			title="Please choose the videos",
			action=gtk.FileChooserAction.OPEN,
			buttons=(gtk.STOCK_CANCEL, gtk.ResponseType.CANCEL,
			gtk.STOCK_OPEN, gtk.ResponseType.OK)
		)
		dialog.set_select_multiple(True)
		dialog.set_local_only(True)
		
		# Filter for videos
		filter_videos = gtk.FileFilter()
		filter_videos.set_name("Video files")
		filter_videos.add_mime_type("video/mp4")
		filter_videos.add_mime_type("video/quicktime")
		dialog.add_filter(filter_videos)

		response = dialog.run()
		
		if response == gtk.ResponseType.CANCEL:
			print("cancelled...")
			sys.exit()

		name = dialog.get_filenames()

		dialog.destroy()

		del dialog

		return name
	else:
		root = tk.Tk()
		root.withdraw()

		path_strings = askopenfilenames(filetypes = [("Video", ".mp4"), ("Video", ".mov")])
		paths = list(root.tk.splitlist(path_strings))

		return paths


def get_save_path():
	if gtk_enabled:
		dialog = gtk.FileChooserDialog(
			title="Please choose the save location",
			action=gtk.FileChooserAction.SELECT_FOLDER,
			buttons=(gtk.STOCK_CANCEL, gtk.ResponseType.CANCEL,
			gtk.STOCK_OPEN, gtk.ResponseType.OK)
		)
		dialog.set_local_only(True)
		
		response = dialog.run()
		
		if response == gtk.ResponseType.CANCEL:
			print("cancelled...")
			sys.exit()

		name = dialog.get_filenames()

		dialog.destroy()

		del dialog
		return name[0]
	else:
	    return filedialog.askdirectory()

if __name__ == "__main__":
    main()
