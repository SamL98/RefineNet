function ds_info=my_gen_ds_info_pascalcontext(ds_config)

ds_dir=fullfile('D:\Datasets\Processed\PascalContext');
load(fullfile(ds_dir, 'dataset_info.mat'), 'num_train', 'num_val', 'num_test');

img_dir=fullfile(ds_dir, 'RGB');
mask_dir=fullfile(ds_dir, 'Truth');

train_img_dir=fullfile(img_dir, 'Train');
val_img_dir=fullfile(img_dir, 'Val');
train_mask_dir=fullfile(mask_dir, 'Train');
val_mask_dir=fullfile(mask_dir, 'Val');

train_file_names=cell(num_train, 1);
for i=1:num_train
    train_file_names{i} = sprintf('train_%06d', i);
end

val_file_names=cell(num_val, 1);
for i=1:num_val
    val_file_names{i} = sprintf('val_%06d', i);
end

img_names=cat(1, train_file_names, val_file_names);
img_num=length(img_names);

img_files=cell(img_num, 1);
mask_files=cell(img_num, 1);

for t_idx=1:num_train
    file_name=img_names{t_idx};
    mask_files{t_idx}=[fullfile('Train', file_name) '_pixeltruth.mat'];
    img_files{t_idx}=[fullfile('Train', file_name) '_img.png'];
end

for t_idx=num_train+1:img_num
    file_name=img_names{t_idx};
    mask_files{t_idx}=[fullfile('Val', file_name), '_pixeltruth.mat'];
    img_files{t_idx}=[fullfile('Val', file_name), '_img.png'];
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

ds_info.class_info=gen_class_info_pascalcontext();

ds_info.ds_name='PascalContext';

ds_info=process_ds_info_classification(ds_info, ds_config);

data_obj=ds_info;
save(fullfile(ds_dir, 'my_dataset_info.mat'), 'data_obj');

end


