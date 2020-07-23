import 'package:flutter/material.dart';
import 'package:reply/details_page.dart';
import 'package:reply/model/email.dart';
import 'package:reply/colors.dart';
import 'package:reply/ui/rounded_avatar.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key key, this.id, this.email, this.onDeleted})
      : super(key: key);

  final int id;
  final Email email;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(email),
      dismissThresholds: const {
        DismissDirection.startToEnd: 0.4,
        DismissDirection.endToStart: 1,
      },
      onDismissed: (DismissDirection direction) {
        switch (direction) {
          case DismissDirection.endToStart:
            // TODO: Handle this case.
            break;
          case DismissDirection.startToEnd:
            onDeleted();
            break;
          default:
          // Do not do anything
        }
      },
      background: Container(
        decoration: BoxDecoration(
          color: ReplyColors.dismissibleBackground,
          border: Border.all(color: ReplyColors.notWhite, width: 2),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Icon(
          Icons.delete_outline,
          size: 36,
          color: Colors.blueGrey[200],
        ),
      ),
      secondaryBackground: Container(
        decoration: BoxDecoration(
          color: ReplyColors.orange,
          border: Border.all(color: ReplyColors.notWhite, width: 2),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Icon(Icons.star_border, size: 36),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Material(
          color: ReplyColors.nearlyWhite,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(context),
                  if (!email.isRead) const SizedBox(height: 14),
                  if (!email.isRead) _emailPreview(context),
                ],
              ),
            ),
            onTap: () => Navigator.of(context)
                .push<void>(DetailsPage.route(context, id, email)),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${email.sender} — ${email.time}',
                style: textTheme.caption.copyWith(
                  color: email.isRead
                      ? ReplyColors.deactivatedText
                      : ReplyColors.darkText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                email.subject,
                style: email.containsPictures
                    ? textTheme.headline5
                    : textTheme.headline6.copyWith(
                        color: email.isRead
                            ? ReplyColors.deactivatedText
                            : ReplyColors.darkText,
                      ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Hero(
            tag: email.subject,
            child: RoundedAvatar(image: 'assets/images/${email.avatar}')),
      ],
    );
  }

  Widget _emailPreview(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (email.hasAttachment)
              const Padding(
                padding: EdgeInsets.only(right: 18),
                child: Icon(
                  Icons.attachment,
                  size: 24,
                  color: Color(0xFF4A6572),
                ),
              ),
            Flexible(
              child: Text(
                email.message,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: textTheme.subtitle2,
              ),
            ),
          ],
        ),
        if (email.containsPictures) ..._miniGallery,
      ],
    );
  }

  List<Widget> get _miniGallery {
    return [
      const SizedBox(height: 21),
      SizedBox(
        width: double.infinity,
        height: 96,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List<Widget>.generate(
            5,
            (int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Image.asset(
                  'assets/images/photo$index.jpg',
                ),
              );
            },
          ),
        ),
      ),
    ];
  }
}
