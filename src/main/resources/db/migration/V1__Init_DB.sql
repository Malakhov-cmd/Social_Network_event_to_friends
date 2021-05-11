create sequence hibernate_sequence start 1 increment 1;

create table dialog (
    id int4 not null,
     dialog_first_user bytea,
      dialog_second_user bytea,
       user_dialog_id int8,
        primary key (id)
    );
create table dialog_mes (
    id int4 not null,
     date_recived varchar(255),
      usr_from bytea,
       mes_txt varchar(2048) not null,
        usr_to bytea,
         dialog_message_id int4,
          primary key (id)
          );
create table message (
id int4 not null,
     activity_type varchar(255),
      date varchar(255),
       filename varchar(2048),
        header varchar(255),
         text varchar(2048) not null,
          theme varchar(255),
           user_id int8,
            room_to_message int8,
             votemessage_id int4,
              room_message_mess_room int8,
               primary key (id)
               );
create table room_message (
    id int8 not null,
     room_message_admin_room bytea,
      room_name varchar(255),
       primary key (id)
       );
create table user_friends (
    friend_id int8 not null,
     friend_list_id int8 not null
     );
create table user_friends_request (
    friend_request_id int8 not null,
     friend_request_list_id int8 not null
     );
create table user_friends_respond (
    friend_respond_id int8 not null,
     friend_respond_list_id int8 not null
     );
create table user_participant (
    room_message_id int8 not null,
     participants_id int8 not null
     );
create table user_role (
    user_id int8 not null,
     roles varchar(255)
     );
create table user_rooms (
    user_rooms_id int8 not null,
     rooms_id int8 not null
     );
create table usr (
    id int8 not null,
     avatar_filename varchar(2048),
      is_active boolean not null,
       password varchar(255) not null,
        username varchar(255) not null,
         primary key (id)
         );
create table vote (
id int4 not null,
     date_voted varchar(255),
      final_voted varchar(255),
       description varchar(255),
        voted_usr bytea,
         vote_message_id int4,
          primary key (id)
          );
create table vote_mess_dialog_mes (
id int4 not null,
     vote_mess_usr_author bytea,
      vote_mess_date_recived varchar(255),
       vote_mes_txt varchar(2048),
        vote_message_dialog_mes_id int4,
         primary key (id)
         );
create table vote_option (
    vote_id int4 not null,
     option_list varchar(255)
     );
create table vote_message (
    id int4 not null,
     message_author bytea,
      vote_message_dialog_id int4,
       user_vote_message_id int8,
        primary key (id)
        );
create table vote_message_dialog (
    id int4 not null,
     vote_message_dialog_user bytea,
      primary key (id)
      );

alter table dialog
 add constraint FK2s7305w9vt24duwe4tbegr8b1
  foreign key (user_dialog_id)
   references usr;

alter table dialog_mes
 add constraint FKskc8dqscvfc56qh68cfhfh9hk
  foreign key (dialog_message_id)
   references dialog;

alter table message
 add constraint FK70bv6o4exfe3fbrho7nuotopf
  foreign key (user_id)
   references usr;

alter table message
 add constraint FK9n80mrqpum17syq4pe35rcfxx
  foreign key (room_to_message)
   references room_message;

alter table message
 add constraint FKguppd6q0c29l9n3faamd8hb1u
  foreign key (votemessage_id)
   references vote_message;

alter table message
 add constraint FKpa9ccolw51dk75yal6bpkhhnb
  foreign key (room_message_mess_room)
   references room_message;

alter table user_friends
 add constraint FK1ohya74awjaqdoviwfer0rr77
  foreign key (friend_list_id)
   references usr;

alter table user_friends
 add constraint FK7yv3plnppnqa4sqr0wn125jps
  foreign key (friend_id)
   references usr;

alter table user_friends_request
 add constraint FK4j531hk9adi91hpadntot38p8
  foreign key (friend_request_list_id)
   references usr;

alter table user_friends_request
 add constraint FKe80o3s884f0ldc4pav5ouyame
  foreign key (friend_request_id)
   references usr;

alter table user_friends_respond
 add constraint FKbpnpoml92ao6nj7fw0f9hdhms
  foreign key (friend_respond_list_id)
   references usr;

alter table user_friends_respond
 add constraint FK3544y74nmf97f5vgjitxwkgyv
  foreign key (friend_respond_id)
   references usr;

alter table user_participant
 add constraint FKtdasggj89hg1gl0306o392f2i
  foreign key (participants_id)
   references usr;

alter table user_participant
 add constraint FKsqsipihk915jxugx0q2mf0pxg
  foreign key (room_message_id)
   references room_message;

alter table user_role
 add constraint FKfpm8swft53ulq2hl11yplpr5
  foreign key (user_id)
   references usr;

alter table user_rooms
 add constraint FKeargsxxxms4y6dwwqf7ns8kmc
  foreign key (rooms_id)
   references room_message;

alter table user_rooms
 add constraint FKaqgqvunxhk2bvi1p1v737st5m
  foreign key (user_rooms_id)
   references usr;

alter table vote
 add constraint FKl2757916mj3hdfuaih8gw5rjl
  foreign key (vote_message_id)
   references vote_message;

alter table vote_mess_dialog_mes
 add constraint FKngk7u9s3bmn5cmhi2mly7dtrr
  foreign key (vote_message_dialog_mes_id)
   references vote_message_dialog;

alter table vote_option
 add constraint FKtbgkw2wpeeygnh7sjwuda3g4a
  foreign key (vote_id)
   references vote;

alter table vote_message
 add constraint FKm27nel5dl6dpt9kkp8yyb9vmj
  foreign key (vote_message_dialog_id)
   references vote_message_dialog;

alter table vote_message
 add constraint FK87ui7klkb6rj6i6hynf1ct3o7
  foreign key (user_vote_message_id)
   references usr;