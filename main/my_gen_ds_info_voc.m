


function ds_info=my_gen_ds_info_voc(ds_config)



ds_dir=fullfile('../datasets', 'voc2012_trainval');
load(fullfile(ds_dir, 'dataset_info.mat'), 'num_train', 'num_val', 'num_test');

img_dir=fullfile(ds_dir, 'RGB');
mask_dir=fullfile(ds_dir, 'Truth');

train_img_dir=fullfile(img_dir, 'Train');
val_img_dir=fullfile(img_dir, 'Val');
train_mask_dir=fullfile(mask_dir, 'Train');
val_mask_dir=fullfile(mask_dir, 'Val');

train_file_names=arrayfun(@(f) extractBefore(f, find(f=='_',1,'last')), dir(train_img_dir));
val_file_names=arrayfun(@(f) extractBefore(f, find(f=='_',1,'last')), dir(val_img_dir));
img_names=cat(1, train_file_names, val_file_names);
img_num=length(img_names);

img_files=cell(img_num, 1);
mask_files=cell(img_num, 1);

for t_idx=1:num_train
    file_name=img_names{t_idx};
    mask_files{t_idx}=[fullfile(train_mask_dir, file_name) '_pixeltruth.mat'];
    img_files{t_idx}=[fullfile(train_img_dir, file_name) '_img.jpg'];
end

for t_idx=num_train+1:img_num
    file_name=img_names{t_idx};
    mask_files{t_idx}=[fullfile(val_mask_dir, file_name), '_pixeltruth.mat'];
    img_files{t_idx}=[fullfile(train_img_dir, file_name), '_img.jpg'];
end

train_idxes=1:num_train;
val_idxes=num_train+1:img_num;

ds_info=[];

ds_info.img_names=img_names;
ds_info.img_files=img_files;
ds_info.mask_files=mask_files;

ds_info.train_idxes=uint32(train_idxes');
ds_info.test_idxes=uint32(val_idxes');

data_dirs=[];
data_dirs{1}=img_dir;
data_dirs{2}=mask_dir;

data_dir_idxes_img=zeros([img_num 1], 'uint8')+1;
data_dir_idxes_mask=zeros([img_num 1], 'uint8')+2;

ds_info.data_dir_idxes_img=data_dir_idxes_img;
ds_info.data_dir_idxes_mask=data_dir_idxes_mask;
ds_info.data_dirs=data_dirs;
ds_info.ds_dir=ds_dir;

ds_info.class_info=gen_class_info_voc();

ds_info.ds_name='voc2012_trainval';

ds_info=process_ds_info_classification(ds_info, ds_config);

end


