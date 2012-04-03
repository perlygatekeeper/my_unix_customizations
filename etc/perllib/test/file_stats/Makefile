files: 
	mkdir -p directory/subdirectory1
	mkdir -p directory/subdirectory2
	mkdir -p directory/subdirectory3
	mkdir -p directory/subdirectory3/subsubdirectory
	mkfile 1k directory/file_1k
	mkfile 2k directory/file_2k
	mkfile 3k directory/file_3k
	mkfile 4k directory/file_4k
	mkfile 1k directory/subdirectory1/file_sub1_1
	mkfile 1k directory/subdirectory1/file_sub1_2
	mkfile 1k directory/subdirectory1/file_sub1_3
	mkfile 1k directory/subdirectory2/file_sub2_1
	mkfile 1k directory/subdirectory2/file_sub2_2
	mkfile 1k directory/subdirectory2/file_sub2_3
	mkfile 1k directory/subdirectory3/file_sub3_1
	mkfile 1k directory/subdirectory3/file_sub3_2
	mkfile 1k directory/subdirectory3/file_sub3_3
	mkfile 1k directory/subdirectory3/subsubdirectory/file_subsub_1
	mkfile 1k directory/subdirectory3/subsubdirectory/file_subsub_2
	mkfile 1k directory/subdirectory3/subsubdirectory/file_subsub_3
	date > date
	mkfile 1k file
	touch file_size_0
	mknod named_pipe p
	ln -s file symlink_to_file
	ln -s directory symlink_to_directory
	ln -s named_pipe symlink_to_named_pipe
	mknod file_block_special b 32655 32655
	mknod file_character_special c 32655 32655
	touch file_executable;	chmod +x	file_executable
	touch file_set_gid;	chmod 4644	file_set_gid
	touch file_set_uid;	chmod 2644	file_set_uid
	touch file_set_sticky;	chmod 1644	file_set_sticky
	ls -lR
